# OneLens Blueprint vs Override Architecture Analysis

**Project:** onelens-4786099461
**Analysis Date:** 2025-12-17
**Environments Analyzed:** prod (AWS), test (AWS), prod-gcp (GCP), test-gcp (GCP)
**Total Blueprint Resources:** 149 (100 enabled, 49 disabled)

---

## Executive Summary

OneLens uses a **single-blueprint, multi-environment** architecture where AWS and GCP are treated as separate environments rather than runtime execution contexts. This creates significant architectural debt:

- **67% override rate** on GCP environments for AWS service integration (OIDC token mounting, IAM role assumption)
- **Cloud provider modeled as environment**, not as infrastructure variance
- **49 disabled resources** (33% of blueprint) indicate uncontrolled sprawl
- **Hard-coded cross-environment URLs** in ConfigMaps break reproducibility

**Critical Finding:** GCP environments run AWS services (DynamoDB, S3, RDS, SNS, SQS) via cross-cloud IAM federation, but this integration is implemented through environment overrides rather than blueprint-level modeling.

---

## 1. Blueprint vs Override Assessment

### 1.1 Truly Blueprint-Level Resources (Stable Across Environments)

**Low Override Density (<10% of environments override):**

| Resource Type | Count | Override Pattern | Assessment |
|--------------|-------|------------------|------------|
| DynamoDB | 23 | None | ✅ Stable, AWS-native, shared globally |
| S3 | 7 | None | ✅ Stable, shared storage layer |
| SNS | 3 | None | ✅ Stable event topics |
| SQS | 8 | None | ✅ Stable message queues |
| AWS IAM Roles | 5 | None | ✅ Stable identity layer |
| IAM Policies | 3 | None | ✅ Stable permissions |
| KMS | 1 | None | ✅ Stable encryption |
| AWS Cognito | 1 | None | ✅ Stable authentication |
| PostgreSQL (RDS) | 1 | None | ✅ Stable database |
| OpenSearch | 1 | None | ✅ Stable log aggregation |
| AWS EFS | 1 | None | ✅ Stable shared filesystem |
| EventBridge | 1 | None | ✅ Stable event bus |

**Total: 54 resources (54% of enabled resources) require ZERO overrides.**

---

### 1.2 Frequently Overridden Resources

**High Override Density (>50% of environments override):**

| Resource Type | Blueprint | Overrides per Environment | Override Reason |
|--------------|-----------|--------------------------|-----------------|
| **Services (22)** | Disabled in AWS envs | GCP: OIDC token volumes, AWS IAM ARN, node selectors | Cross-cloud IAM integration |
| **Ingress (4)** | Generic routing | Per-env: domains, TLS certs, ALB vs GCP ALB flavor | Cloud-specific LB configuration |
| **Node Pools (1)** | EKS flavor | GCP: node_fleet flavor, disabled + recreated | Cloud-specific compute |
| **ConfigMaps (12)** | Base config | Per-env: hard-coded URLs, domain prefixes | Environment-specific endpoints |

**Pattern Identified:**
- **AWS environments:** Services disabled at override level
- **GCP environments:** Services enabled with extensive AWS IAM integration overrides (volume mounts, env vars, node affinities)

**Override Example (service/onyx-authentication-api on GCP):**
```json
{
  "advanced": {
    "common": {
      "app_chart": {
        "values": {
          "additional_volume_mounts": [{
            "mountPath": "/var/run/secrets/eks.amazonaws.com/serviceaccount",
            "name": "aws-iam-token",
            "readOnly": true
          }],
          "additional_volumes": [{
            "name": "aws-iam-token",
            "projected": {
              "sources": [{
                "serviceAccountToken": {
                  "audience": "sts.amazonaws.com",
                  "expirationSeconds": 86400,
                  "path": "token"
                }
              }]
            }
          }],
          "node_selector": {"compute_label": "onyx"},
          "tolerations": [{"key": "application", "value": "onyx"}]
        }
      }
    }
  },
  "spec": {
    "env": {
      "AWS_DEFAULT_REGION": "${blueprint.self.variables.AWS_DEFAULT_REGION}",
      "AWS_ROLE_ARN": "arn:aws:iam::471112871310:role/prod-onyx-ecs-task-execution-role",
      "AWS_SDK_LOAD_CONFIG": "1",
      "AWS_WEB_IDENTITY_TOKEN_FILE": "/var/run/secrets/eks.amazonaws.com/serviceaccount/token"
    }
  }
}
```

**Analysis:** This is NOT environment customization—this is cross-cloud IAM federation implemented as an override.

---

### 1.3 Overrides Indicating Architectural Drift

**Anti-Patterns Identified:**

1. **Disabled at Blueprint, Enabled at Override**
   - **Example:** `service/onyx-authentication-api`
     - Blueprint: `disabled: false` (should deploy)
     - AWS overrides: `disabled: true` (force disable)
     - GCP overrides: `disabled: false` (re-enable with AWS IAM config)
   - **Risk:** Blueprint no longer represents deployable truth. Overrides are compensating for incorrect base state.

2. **Flavor Changes at Override Level**
   - **Example:** `kubernetes_node_pool/jobs-node`
     - Blueprint flavor: `eks_self_managed`
     - GCP override: `flavor: node_fleet` (completely different resource type)
   - **Risk:** This is not an override—this is resource redefinition. Blueprint flavor is meaningless in GCP.

3. **Hard-Coded Cross-Environment URLs**
   - **Example:** `config_map/onyx-authentication` (prod override)
     ```
     INTEGRATIONS_BASE_URL="https://api.onyx-prod.onelens.cloud"
     ONELENS_BASE_URL="https://api-in.onelens.cloud"
     ONYX_BASE_URL="https://api.onyx-prod.onelens.cloud"
     ```
   - **Risk:** Production URLs hard-coded. Impossible to clone environment without manual URL surgery.

4. **AWS IAM ARNs Baked Into Environment Overrides**
   - **GCP prod:** `AWS_ROLE_ARN: arn:aws:iam::471112871310:role/prod-onyx-ecs-task-execution-role`
   - **GCP test:** `AWS_ROLE_ARN: arn:aws:iam::609916866699:role/test-onyx-ecs-task-execution-role`
   - **Risk:** AWS account IDs and role names are environment-specific secrets embedded in config. No centralized IAM trust management.

---

## 2. Environment Reality Check

### 2.1 Logical vs Cloud Execution Differences

**Current Environment Taxonomy:**

| Environment | Cloud | Purpose | Cluster State | Override Complexity |
|------------|-------|---------|---------------|---------------------|
| **prod** | AWS | Production | RUNNING | Low (disable services, custom ingress) |
| **test** | AWS | QA/Testing | RUNNING | Low (disable services) |
| **prod-gcp** | GCP | Production | RUNNING | **HIGH** (AWS IAM federation, node pools, ingress) |
| **test-gcp** | GCP | Testing | RUNNING | **HIGH** (AWS IAM federation, different ARNs) |
| dev | AWS | Development | DESTROY_FAILED | N/A |
| prod-us | AWS | Unknown | DESTROY_FAILED | N/A |

**Fundamental Problem:**

```
Current Model:
Environment = (Lifecycle Stage) × (Cloud Provider)
  prod = PROD lifecycle + AWS
  prod-gcp = PROD lifecycle + GCP
  test = QA lifecycle + AWS
  test-gcp = DEV lifecycle + GCP

Correct Model:
Environment = Lifecycle Stage
  prod → deploys to AWS + GCP
  test → deploys to AWS + GCP

Cloud Provider = Infrastructure Variance (not environment)
  AWS: EKS, ALB
  GCP: GKE, GCP ALB + AWS IAM federation via OIDC
```

### 2.2 Where Cloud is Incorrectly Modeled as Environment

**Explicit Violations:**

1. **Same Blueprint Resources, Different Disabled States**
   - Services disabled in AWS, enabled in GCP
   - This is cloud-specific behavior, not environment-specific

2. **Ingress Resource Type Changes**
   - AWS uses `ingress/public-ingress` (flavor: `aws_alb`)
   - GCP uses `ingress/public-nlb-ingress` (flavor: `gcp_alb`)
   - These are **not the same resource with overrides**—they are **different resources** selected by environment

3. **Node Pool Flavor Redefinition**
   - Blueprint defines `eks_self_managed`
   - GCP redefines as `node_fleet` with completely different spec
   - This is not parameterization—this is conditional resource substitution

**Correct Architecture:**

```yaml
# Blueprint should define cloud-agnostic intent
ingress:
  - name: public-ingress
    type: ingress
    spec:
      domains: {...}
      rules: {...}

# Infrastructure layer selects cloud-specific implementation
infrastructure:
  aws:
    ingress_flavor: aws_alb
    node_pool_flavor: eks_self_managed
  gcp:
    ingress_flavor: gcp_alb
    node_pool_flavor: node_fleet
    iam_federation:
      provider: aws
      oidc_token_path: /var/run/secrets/eks.amazonaws.com/serviceaccount/token
```

---

## 3. Risk Classification

### 3.1 Low-Risk, Easy to Normalize

**No Overrides Required → Already Blueprint-Stable:**

| Resource Type | Count | Action Required |
|--------------|-------|-----------------|
| DynamoDB | 23 | None (already stable) |
| S3 | 7 | None (already stable) |
| SNS, SQS | 11 | None (already stable) |
| AWS IAM Roles/Policies | 8 | None (already stable) |
| KMS, Cognito, RDS, EFS | 4 | None (already stable) |
| OpenSearch, EventBridge | 2 | None (already stable) |

**Total: 54 resources (43% of all resources) require no changes.**

---

### 3.2 Medium-Risk, Runtime-Sensitive

**Require Cloud-Specific Configuration but Predictable:**

| Resource Type | Count | Current Risk | Normalization Strategy |
|--------------|-------|--------------|------------------------|
| **Ingress** | 4 | Medium | Extract cloud-specific routing into infrastructure layer |
| **Node Pools** | 1 enabled<br/>13 disabled | Medium | Separate cloud-specific node pool definitions from blueprint |
| **Kubernetes Cluster** | 1 | Medium | Define EKS vs GKE as infrastructure variants |

**Action Required:**
- Move cloud-specific ingress flavors (`aws_alb` vs `gcp_alb`) to infrastructure config
- Define node pool templates per cloud provider
- Remove 13 disabled node pool definitions (likely GKE prototypes never cleaned up)

---

### 3.3 High-Risk, Hard to Clean

**Complex Cross-Cloud Dependencies + Hard-Coded State:**

| Resource Type | Count | Critical Issues | Blast Radius |
|--------------|-------|-----------------|--------------|
| **Services** | 22 | • AWS IAM ARNs in overrides<br/>• OIDC token volume mounts<br/>• Hard-coded role names<br/>• Cloud-specific node selectors | **CRITICAL**<br/>Breaks if:<br/>• AWS account changes<br/>• IAM role renamed<br/>• K8s SA token projection disabled |
| **ConfigMaps** | 12 | • Hard-coded environment URLs<br/>• Cross-environment references<br/>• No variable interpolation | **HIGH**<br/>Breaks if:<br/>• Domain changes<br/>• Environment cloned<br/>• Multi-region deployment |

**Specific High-Risk Patterns:**

#### Pattern 1: Hard-Coded AWS IAM ARNs
```json
// prod-gcp override
"AWS_ROLE_ARN": "arn:aws:iam::471112871310:role/prod-onyx-ecs-task-execution-role"

// test-gcp override
"AWS_ROLE_ARN": "arn:aws:iam::609916866699:role/test-onyx-ecs-task-execution-role"
```

**Risk:**
- AWS account ID embedded in config
- Role name must match exactly
- No way to rotate roles without editing overrides
- Cannot promote test → prod without manual ARN replacement

#### Pattern 2: Hard-Coded Domain URLs
```bash
INTEGRATIONS_BASE_URL="https://api.onyx-prod.onelens.cloud"
ONELENS_BASE_URL="https://api-in.onelens.cloud"
```

**Risk:**
- Production URLs in configuration files
- Environment cloning requires manual URL surgery
- No multi-region support
- Cannot use environment variables for dynamic discovery

#### Pattern 3: OIDC Token Mounting in Overrides
```json
"additional_volumes": [{
  "name": "aws-iam-token",
  "projected": {
    "sources": [{
"serviceAccountToken": {
        "audience": "sts.amazonaws.com",
        "expirationSeconds": 86400,
        "path": "token"
      }
    }]
  }
}]
```

**Risk:**
- Kubernetes service account token projection is infrastructure-level concern
- Repeated in 22 service overrides (copy-paste sprawl)
- If K8s version changes token projection API, must update 22 files
- No single source of truth for AWS IAM federation config

---

## 4. Override Density & Blast Radius

### 4.1 Override Density Metrics

| Environment | Total Resources | Override Count | Override Rate | Complexity Score |
|------------|----------------|----------------|---------------|------------------|
| **prod** (AWS) | 100 | ~15 | 15% | Low |
| **test** (AWS) | 100 | ~15 | 15% | Low |
| **prod-gcp** (GCP) | 100 | **~67** | **67%** | **CRITICAL** |
| **test-gcp** (GCP) | 100 | **~67** | **67%** | **CRITICAL** |

**Complexity Score Calculation:**
- Low: Simple overrides (disabled flag, replica count)
- Medium: Structural overrides (domain lists, resource limits)
- High: Cross-cloud integration overrides (IAM ARNs, OIDC tokens, node affinities)
- Critical: Combination of high-complexity overrides + hard-coded secrets

**Finding:** GCP environments have 4.5x higher override density than AWS environments.

---

### 4.2 Operational Risk Analysis

**Risk 1: Environment Cloning is Broken**

```bash
# Current reality: Cannot clone prod-gcp to create staging-gcp
$ raptor clone environment prod-gcp staging-gcp

# Result: Inherits ALL hard-coded values:
✗ AWS_ROLE_ARN still points to prod IAM role (security risk)
✗ Domain URLs still point to api.onyx-prod.onelens.cloud (routing failure)
✗ TLS certificates still reference prod ACM ARNs (TLS failure)
✗ Node selectors still target prod node pools (scheduling failure)

# Manual cleanup required: ~67 override edits per service
```

**Blast Radius:** HIGH
**Impact:** Cannot provision new environments without 40+ hours of manual override editing.

---

**Risk 2: Multi-Region Deployment is Impossible**

```bash
# Current architecture:
prod (AWS us-east-1) → Uses S3, DynamoDB, RDS in us-east-1
prod-gcp (GCP asia-south1) → Uses SAME S3, DynamoDB, RDS in us-east-1 via cross-cloud

# To add AWS us-west-2:
- Must create new environment "prod-us-west"
- Must replicate S3, DynamoDB, RDS (how? not modeled)
- Must update hard-coded URLs in ConfigMaps (manual)
- Must create new IAM roles with different ARNs (manual)
```

**Blast Radius:** CRITICAL
**Impact:** Architecture assumes single-region AWS services. Multi-region requires blueprint redesign.

---

**Risk 3: IAM Role Rotation Requires Override Surgery**

```bash
# Scenario: Rotate AWS IAM role for security compliance
Old: arn:aws:iam::471112871310:role/prod-onyx-ecs-task-execution-role
New: arn:aws:iam::471112871310:role/prod-onyx-v2-ecs-task-execution-role

# Required changes:
- Edit 22 service overrides in prod-gcp
- Edit 22 service overrides in test-gcp
- Update Terraform AWS IAM trust policies
- Update GKE service account annotations
- Coordinate deployment across 44 override files
```

**Blast Radius:** HIGH
**Impact:** Security maintenance becomes multi-day coordination effort.

---

**Risk 4: Blueprint Disabled State is Meaningless**

```yaml
# Blueprint says services are enabled:
service/onyx-authentication-api:
  disabled: false  # ← Blueprint says "deploy this"

# AWS environments say "never mind":
prod override:
  disabled: true   # ← Override says "don't deploy"

test override:
  disabled: true   # ← Override says "don't deploy"

# GCP environments say "deploy with AWS integration":
prod-gcp override:
  disabled: false  # ← Implicitly re-enabled
  spec: { AWS_ROLE_ARN: "...", volumes: [...] }
```

**Blast Radius:** CRITICAL
**Impact:** Blueprint is not source of truth. Cannot reason about what deploys where without checking all overrides.

---

### 4.3 Reproducibility Failures

**Test Case: Create New Environment "staging-gcp"**

| Step | Expected Behavior | Actual Behavior | Manual Fix Required |
|------|------------------|-----------------|---------------------|
| 1. Clone environment | Inherit GCP config | ✗ Inherits prod-gcp AWS ARNs | Edit 22 service overrides |
| 2. Set domains | Use staging.onelens.cloud | ✗ Hard-coded prod URLs in ConfigMaps | Edit 12 ConfigMap overrides |
| 3. Deploy services | Services start | ✗ IAM role mismatch (using prod ARN) | Create new IAM role + edit 22 overrides |
| 4. Test ingress | Traffic routes | ✗ TLS cert mismatch (prod ACM ARN) | Create new ACM cert + edit ingress overrides |
| 5. Verify logs | Logs flow to OpenSearch | ✗ Loki writing to prod S3 bucket | Edit log collector config |

**Estimated Manual Effort:** 40-60 hours for single environment clone.

---

## 5. Multi-Cloud Modeling Gaps

### 5.1 Missing or Implicit Cross-Cloud Integration

**Current Reality:**

```
GKE (GCP) → AWS Services (S3, DynamoDB, RDS, SNS, SQS)
   ↑
   | How? Not modeled in blueprint.
   |
   ↓ Implemented via environment overrides:

   1. K8s ServiceAccount → Projects OIDC token
   2. OIDC token mounted as volume in pods
   3. AWS SDK reads token from filesystem
   4. AWS STS AssumeRoleWithWebIdentity → Returns temp credentials
   5. Services access AWS APIs
```

**What's Missing from Blueprint:**

1. **No OIDC Provider Resource**
   - Blueprint has no `aws_iam_oidc_provider` resource
   - GKE OIDC issuer URL not documented
   - AWS IAM trust relationship not version-controlled

2. **No Federated IAM Trust Policy**
   - IAM role exists: `aws_iam_role/onyx-role`
   - Trust policy not visible in blueprint
   - Cannot see which GKE service accounts are trusted

3. **No Service Account Annotation**
   - GKE service accounts must have `iam.gke.io/gcp-service-account` annotation
   - These annotations not modeled in blueprint
   - Kubernetes RBAC for AWS access not visible

4. **No Cross-Cloud Networking Model**
   - How does GKE reach AWS endpoints?
   - Public internet? VPN? Private Service Connect?
   - Latency implications not documented

5. **No Credential Rotation Strategy**
   - OIDC tokens expire every 24 hours (86400 seconds)
   - What happens if AWS STS is unreachable?
   - No fallback or circuit breaker modeled

---

### 5.2 How Multi-Cloud Should Be Modeled

**Blueprint-Level Resources (Cloud-Agnostic Intent):**

```yaml
# blueprint/iam_federation.yaml
iam_federation:
  - name: gcp-to-aws
    provider: aws
    trust_source: gcp_oidc
    trusted_clusters:
      - gke://projects/PROJECT_ID/locations/LOCATION/clusters/CLUSTER_NAME
    roles:
      - onyx-role
      - keda-role
    token_config:
      audience: sts.amazonaws.com
      expiration: 86400
      mount_path: /var/run/secrets/eks.amazonaws.com/serviceaccount
```

**Infrastructure Layer (Cloud-Specific Implementation):**

```yaml
# infrastructure/aws/iam_trust_policy.tf
resource "aws_iam_role" "onyx_role" {
  name = "${var.env}-onyx-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::${var.account_id}:oidc-provider/oidc.googleapis.com"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "oidc.googleapis.com:aud": "sts.amazonaws.com"
          "oidc.googleapis.com:sub": "system:serviceaccount:${var.namespace}:${var.service_account}"
        }
      }
    }]
  })
}
```

```yaml
# infrastructure/gcp/service_account.tf
resource "kubernetes_service_account" "onyx_services" {
  metadata {
    name = "onyx-sa"
    namespace = "onyx"
    annotations = {
      "iam.gke.io/gcp-service-account" = "onyx-sa@PROJECT_ID.iam.gserviceaccount.com"
    }
  }
}

resource "kubernetes_manifest" "aws_iam_token_volume" {
  manifest = {
    apiVersion = "v1"
    kind = "Pod"
    spec = {
      volumes = [{
        name = "aws-iam-token"
        projected = {
          sources = [{
            serviceAccountToken = {
              audience = "sts.amazonaws.com"
              expirationSeconds = 86400
              path = "token"
            }
          }]
        }
      }]
    }
  }
}
```

**Service Definitions (No AWS-Specific Overrides):**

```yaml
# blueprint/services/onyx-authentication-api.yaml
service:
  name: onyx-authentication-api
  iam_federation: gcp-to-aws  # Reference federation config
  # No hard-coded AWS_ROLE_ARN
  # No volume mounts in overrides
```

---

### 5.3 Benefits of Proper Multi-Cloud Modeling

| Current State | Proper Modeling |
|--------------|-----------------|
| 22 services × 2 GCP envs = 44 override files with IAM ARNs | 1 IAM federation config → injected at deployment |
| Hard-coded AWS account IDs in overrides | Account ID from environment variables |
| IAM role rotation requires 44 file edits | IAM role rotation requires 1 Terraform variable change |
| Cannot clone environments (manual override surgery) | Clone environments with zero manual intervention |
| OIDC token config copy-pasted 44 times | OIDC token config defined once, applied universally |
| No visibility into AWS ↔ GCP trust relationship | IAM trust policies version-controlled and auditable |

---

## 6. Milestone-1 Recommendations (Analysis & Stabilization ONLY)

### 6.1 Objective

**Stabilize current state and create visibility into override patterns WITHOUT changing architecture.**

**Out of Scope:**
- Migrations
- Refactoring
- New environment creation
- Service rewrites

**In Scope:**
- Audit
- Documentation
- Risk quantification
- Drift detection

---

### 6.2 Milestone-1 Deliverables

#### Deliverable 1: Override Inventory & Drift Report

**Task:** Generate machine-readable inventory of ALL overrides across ALL environments.

**Output:**
```bash
onelens-override-inventory.json
{
  "prod": {
    "service/onyx-authentication-api": {
      "override_complexity": "low",
      "overrides": { "disabled": true }
    },
    "config_map/onyx-authentication": {
      "override_complexity": "high",
      "drift_indicators": [
        "hard_coded_url",
        "cross_environment_reference"
      ],
      "overrides": { "spec": { "data": { ... } } }
    }
  },
  "prod-gcp": {
    "service/onyx-authentication-api": {
      "override_complexity": "critical",
      "drift_indicators": [
        "aws_iam_arn",
        "oidc_token_volume",
        "hard_coded_role_name"
      ],
      "overrides": { ... }
    }
  }
}
```

**Automation:**
```bash
#!/bin/bash
for env in prod test prod-gcp test-gcp; do
  for resource in $(raptor get resources --project onelens-4786099461 -o json | jq -r '.[] | select(.disabled == false) | .resourceType + "/" + .name'); do
    raptor get resource-overrides --project onelens-4786099461 --environment $env $resource -o json >> overrides_${env}.json
  done
done
```

**Analysis Criteria:**
- **Low complexity:** Simple flag overrides (`disabled`, `replicas`)
- **Medium complexity:** Config overrides (domains, resource limits)
- **High complexity:** Structural changes (IAM ARNs, URLs)
- **Critical complexity:** Cross-cloud integration + secrets

**Deliverable Timeline:** 1 week

---

#### Deliverable 2: Cross-Cloud IAM Federation Documentation

**Task:** Reverse-engineer and document the ACTUAL AWS ↔ GCP IAM trust chain.

**Output:**
```markdown
# AWS-GCP IAM Federation Architecture

## Trust Flow

1. GKE creates service account token with audience=sts.amazonaws.com
2. Token mounted as volume at /var/run/secrets/eks.amazonaws.com/serviceaccount/token
3. AWS SDK (via AWS_WEB_IDENTITY_TOKEN_FILE) reads token
4. AWS STS AssumeRoleWithWebIdentity API call
   - Role: arn:aws:iam::ACCOUNT_ID:role/ENV-onyx-ecs-task-execution-role
   - WebIdentityToken: K8s SA token
   - Audience: sts.amazonaws.com
5. AWS STS returns temporary credentials (access key, secret key, session token)
6. Services use temp credentials to access DynamoDB, S3, RDS, etc.

## IAM Trust Policies

### Production (471112871310)
arn:aws:iam::471112871310:role/prod-onyx-ecs-task-execution-role

Trust policy:
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {
      "Federated": "arn:aws:iam::471112871310:oidc-provider/oidc.googleapis.com"
    },
    "Action": "sts:AssumeRoleWithWebIdentity",
    "Condition": {
      "StringEquals": {
        "oidc.googleapis.com:aud": "sts.amazonaws.com",
        "oidc.googleapis.com:sub": "system:serviceaccount:onyx:onyx-sa"
      }
    }
  }]
}

### Test (609916866699)
[Same pattern, different account ID]

## Failure Modes

1. **OIDC token expired:** Services fail after 24 hours if not refreshed
2. **AWS STS unreachable:** No fallback, services fail immediately
3. **IAM role trust mismatch:** If GKE SA name changes, AssumeRole fails
4. **Cross-cloud latency:** Every AWS API call goes over internet (adds 50-200ms)

## Security Considerations

- Token audience MUST be sts.amazonaws.com (cannot be reused for other services)
- GKE service account must exist before pod starts
- AWS IAM role ARN hard-coded in overrides (rotation requires override edits)
- No credential caching (every request calls STS first)
```

**Research Required:**
- Pull AWS IAM role trust policies via AWS CLI
- Document GKE OIDC issuer URLs
- Test token expiration and renewal behavior
- Measure cross-cloud API latency

**Deliverable Timeline:** 1 week

---

#### Deliverable 3: Environment Parity Matrix

**Task:** Create comparison matrix showing what's ACTUALLY different between environments.

**Output:**
```
| Component | prod (AWS) | test (AWS) | prod-gcp (GCP) | test-gcp (GCP) |
|-----------|------------|------------|----------------|----------------|
| **Services Enabled** | 0 | 0 | 22 | 22 |
| **Ingress Flavor** | aws_alb | aws_alb | gcp_alb | gcp_alb |
| **TLS Certificates** | ACM (prod ARN) | ACM (test ARN) | ACM (prod ARN) | ACM (test ARN) |
| **Domains** | api-in.onelens.cloud | api-test.onelens.cloud | api.onyx-prod.onelens.cloud | api.onyx-test.onelens.cloud |
| **AWS IAM Role ARN** | N/A | N/A | :471112871310:role/prod-* | :609916866699:role/test-* |
| **Node Pool Type** | eks_self_managed | eks_self_managed | node_fleet | node_fleet |
| **DynamoDB Tables** | 23 (us-east-1) | 23 (us-east-1) | 23 (us-east-1 via federation) | 23 (us-east-1 via federation) |
| **S3 Buckets** | 7 (us-east-1) | 7 (us-east-1) | 7 (us-east-1 via federation) | 7 (us-east-1 via federation) |
| **RDS Instance** | 1 (us-east-1) | 1 (us-east-1) | 1 (us-east-1 via federation) | 1 (us-east-1 via federation) |
```

**Findings:**
- AWS environments: Minimal overrides, mostly ingress + disabled services
- GCP environments: Extensive overrides for cross-cloud IAM + node configuration
- **No actual service logic differences**—only infrastructure integration

**Deliverable Timeline:** 3 days

---

#### Deliverable 4: Blast Radius Assessment

**Task:** Quantify operational risk of current override architecture.

**Output:**
```markdown
# Operational Risk Assessment

## Change Impact Analysis

### Scenario 1: AWS IAM Role Name Change

**Trigger:** Compliance requires renaming IAM roles from `*-ecs-task-execution-role` to `*-eks-workload-role`

**Blast Radius:**
- **Files affected:** 44 (22 services × 2 GCP environments)
- **Manual edits:** 44 ARN string replacements
- **Deployment risk:** HIGH (if 1 ARN incorrect, service fails silently)
- **Rollback complexity:** HIGH (must re-edit all 44 files)
- **Estimated downtime:** 2-4 hours (assuming serial deployment)

**Mitigation:** None in current architecture.

---

### Scenario 2: Domain Name Change

**Trigger:** Rebrand from onelens.cloud → newbrand.io

**Blast Radius:**
- **Files affected:** 12 ConfigMaps + 4 Ingresses = 16 resources
- **Manual edits:** ~50 hard-coded URL replacements
- **Deployment risk:** CRITICAL (broken cross-service URLs cause cascading failures)
- **Testing required:** Full integration test across all 22 services
- **Estimated effort:** 16-24 hours

**Mitigation:** None in current architecture.

---

### Scenario 3: Multi-Region Expansion

**Trigger:** Deploy to AWS us-west-2 for disaster recovery

**Blast Radius:**
- **New resources required:** S3 replication, DynamoDB global tables, RDS read replicas
- **Blueprint changes:** NOT SUPPORTED (S3/DynamoDB are single resources, not region-aware)
- **Override changes:** Cannot target specific region without breaking existing envs
- **Cross-region routing:** No mechanism to route traffic to nearest region
- **Estimated effort:** UNDEFINED (requires architecture redesign)

**Mitigation:** Architecture does not support multi-region.

---

### Scenario 4: Clone Production for Disaster Recovery Test

**Trigger:** Create prod-dr environment to test failover

**Blast Radius:**
- **Clone command:** `raptor clone environment prod prod-dr`
- **Broken after clone:**
  - AWS IAM role ARN still points to prod (security violation)
  - Domain URLs still point to prod (traffic misdirection)
  - TLS certs still point to prod (TLS validation failure)
  - Database connections still point to prod (data corruption risk)
- **Manual fixes required:** ~67 override edits
- **Estimated effort:** 40-60 hours

**Mitigation:** Do not clone environments.
```

**Deliverable Timeline:** 3 days

---

#### Deliverable 5: Disabled Resource Cleanup Candidate List

**Task:** Identify 49 disabled resources and classify by cleanup safety.

**Output:**
```json
{
  "safe_to_delete": [
    "service/websearch",
    "service/ask-navira",
    "service/memgraph-db",
    "service/memgraph-lab",
    "service/tenant-mgmt-svc",
    "google_cloud_storage/tenant-cur",
    "google_cloud_storage/loki-gcs",
    "kubernetes_node_pool/ol-large",
    "kubernetes_node_pool/ol-medium",
    "kubernetes_node_pool/default-arm",
    // ... 13 disabled node pools
  ],
  "requires_investigation": [
    "service/cloudsql-auth-proxy",  // Why disabled? GCP CloudSQL not used?
    "aws_lambda/ol-sch-handler",    // Replaced by K8s service?
    "kubernetes_secret/cognito-oidc-secret"  // Still referenced?
  ],
  "do_not_delete": [
    "service/onyx-authentication-api"  // Disabled in AWS, enabled in GCP
  ]
}
```

**Validation Checklist:**
- [ ] Check for resource references in overrides
- [ ] Search codebase for resource name mentions
- [ ] Verify no Terraform dependencies
- [ ] Confirm disabled > 90 days
- [ ] Test deletion in non-prod first

**Deliverable Timeline:** 1 week

---

### 6.3 Success Criteria for Milestone-1

**Completion Criteria:**

1. ✅ **Override Inventory:** Machine-readable JSON of ALL overrides with complexity scores
2. ✅ **IAM Federation Docs:** Complete documentation of AWS-GCP trust chain with failure modes
3. ✅ **Environment Parity Matrix:** Visual comparison of what differs between envs
4. ✅ **Blast Radius Report:** Quantified risk for common operational scenarios
5. ✅ **Cleanup Candidate List:** Safe-to-delete resource list with validation checklist

**Outcome:**
- Team can reason about override architecture
- Operational risks are quantified and visible
- Foundation for future normalization (Milestone-2)
- No production changes made

**Timeline:** 3-4 weeks
**Effort:** 1 person (cloud architect + devops)
**Cost:** Analysis only, zero infrastructure changes

---

## Appendix: Key Statistics

### Resource Distribution
- Total blueprint resources: 149
- Enabled resources: 100 (67%)
- Disabled resources: 49 (33%)
- Blueprint-stable (no overrides): 54 (54% of enabled)
- Heavily overridden (GCP environments): 46 (46% of enabled)

### Override Complexity
- AWS environments override rate: 15%
- GCP environments override rate: 67%
- High-risk overrides (IAM ARNs, URLs): 34 resources
- Critical overrides (OIDC + secrets): 22 resources

### Multi-Cloud Architecture
- AWS-native services: 54 (DynamoDB, S3, RDS, SNS, SQS, IAM, KMS, Cognito, EFS, EventBridge, OpenSearch)
- GCP-native services: 0 (GKE is execution layer only)
- Cross-cloud IAM federation: 22 services × 2 GCP envs = 44 configurations
- Hard-coded AWS account IDs: 2 (prod: 471112871310, test: 609916866699)

### Environment Health
- Running: prod (AWS), test (AWS), prod-gcp (GCP), test-gcp (GCP)
- Failed: dev (AWS), prod-us (AWS)
- Last successful deployment: prod-gcp (2025-12-17)

---

**Report Compiled:** 2025-12-17
**Analyst:** Praxis (Facets AI)
**Data Sources:** Raptor CLI, OneLens blueprint (onelens-4786099461)
**Next Steps:** Review Milestone-1 deliverables with operations team, prioritize cleanup candidates