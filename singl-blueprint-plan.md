# Single Blueprint - Multi-Cloud Architecture

## Concept: One Blueprint, Multiple Cloud Environments

```
Blueprint (Cloud-Agnostic)
├── Resources defined once
│
├─→ Environment: AWS Production
│   └── Overrides: Use AWS flavors (eks, rds, s3)
│
└─→ Environment: GCP Production
    └── Overrides: Use GCP flavors (gke, gcp_cloudsql, gcs)
```

---

## 📋 Single Blueprint Resource Types (18 types)

### 1. Storage Resources (3 types)

#### Object Storage
**Resource Type:** `s3` (use this name even for GCP)
**Blueprint (default):** `flavor: default, version: 0.2`
**AWS Environment Override:** `flavor: default` (AWS S3)
**GCP Environment Override:** Change to `google_cloud_storage` with `flavor: default, version: 0.1`

#### NoSQL Database
**Resource Type:** `dynamodb`
**Blueprint (default):** `flavor: astuto-dynamodb, version: 0.1`
**AWS Environment:** Keep as-is
**GCP Environment:** ⚠️ Need GCP equivalent (firestore/bigtable)

#### SQL Database
**Resource Type:** `postgres`
**Blueprint (default):** `flavor: rds, version: 0.1`
**AWS Environment Override:** `flavor: rds`
**GCP Environment Override:** `flavor: gcp_cloudsql`

---

### 2. Messaging Resources (2 types)

#### Message Queues
**Resource Type:** `sqs`
**Blueprint (default):** `flavor: default, version: 0.2`
**AWS Environment:** Keep as-is
**GCP Environment:** ⚠️ Need GCP equivalent (cloud_pubsub)

#### Pub/Sub Notifications
**Resource Type:** `sns`
**Blueprint (default):** `flavor: default, version: 0.1`
**AWS Environment:** Keep as-is
**GCP Environment:** ⚠️ Need GCP equivalent (cloud_pubsub)

---

### 3. Security Resources (3 types)

#### Encryption Keys
**Resource Type:** `kms`
**Blueprint (default):** `flavor: default, version: 0.1`
**AWS Environment:** Keep as-is (AWS KMS)
**GCP Environment Override:** `flavor: gcp_kms` (if exists)

#### IAM Policies
**Resource Type:** `iam_policy`
**Blueprint (default):** `flavor: aws_iam_policy, version: 0.2`
**AWS Environment:** Keep as-is
**GCP Environment:** ⚠️ Need GCP equivalent

#### IAM Roles
**Resource Type:** `aws_iam_role`
**Blueprint (default):** `flavor: default, version: 0.1`
**AWS Environment:** Keep as-is
**GCP Environment:** ⚠️ Need GCP equivalent

---

### 4. Kubernetes Resources (5 types)

#### Kubernetes Cluster
**Resource Type:** `kubernetes_cluster`
**Blueprint (default):** `flavor: default, version: 0.1`
**AWS Environment Override:** Set to use EKS
**GCP Environment Override:** Set to use GKE

#### Kubernetes Node Pools
**Resource Type:** `kubernetes_node_pool`
**Blueprint (default):** `flavor: eks_managed, version: 0.2`
**AWS Environment Override:** `flavor: eks_managed`
**GCP Environment Override:** `flavor: gke_node_pool, version: 0.1`

#### Ingress Controllers
**Resource Type:** `ingress`
**Blueprint (default):** `flavor: nginx_k8s_native, version: 0.1`
**AWS Environment Override:** `flavor: aws_alb` (if ALB preferred)
**GCP Environment Override:** `flavor: gcp_alb` OR keep nginx

#### ConfigMaps
**Resource Type:** `config_map`
**Blueprint (default):** `flavor: k8s, version: 0.3`
**Both Environments:** Same (cloud-agnostic)

#### Helm Charts
**Resource Type:** `helm`
**Blueprint (default):** `flavor: helm_simple`
**Both Environments:** Same (cloud-agnostic)

---

### 5. Application Resources (1 type)

#### Services
**Resource Type:** `service`
**Blueprint (default):** `flavor: k8s, version: 0.1`
**Both Environments:** Same (cloud-agnostic)

---

### 6. Observability Resources (3 types)

#### Log Collector
**Resource Type:** `log_collector`
**Blueprint (default):** `flavor: loki_aws_s3, version: 0.2`
**AWS Environment:** Keep as-is (logs to S3)
**GCP Environment Override:** `flavor: loki_gcs` (if exists, logs to GCS)

#### Grafana Dashboards
**Resource Type:** `grafana_dashboard`
**Blueprint (default):** `flavor: default, version: latest`
**Both Environments:** Same (cloud-agnostic)

#### Monitoring Stack
**Resource Type:** `kubernetes_monitoring`
**Blueprint (default):** `flavor: k8s, version: 0.1`
**Both Environments:** Same (cloud-agnostic)

---

### 7. Network Resources (1 type)

#### Network/VPC
**Resource Type:** `network`
**Blueprint (default):** `flavor: default, version: 0.1`
**Both Environments:** Same (cloud creates VPC automatically)

---

## 📊 Complete Blueprint Resource Type List

| # | Resource Type | Default Flavor | Default Version | Cloud-Agnostic? |
|---|--------------|----------------|-----------------|-----------------|
| 1 | `s3` | default | 0.2 | ❌ (AWS-specific) |
| 2 | `dynamodb` | astuto-dynamodb | 0.1 | ❌ (AWS-specific) |
| 3 | `postgres` | rds | 0.1 | ✅ (change flavor) |
| 4 | `sqs` | default | 0.2 | ❌ (AWS-specific) |
| 5 | `sns` | default | 0.1 | ❌ (AWS-specific) |
| 6 | `kms` | default | 0.1 | ✅ (change flavor) |
| 7 | `iam_policy` | aws_iam_policy | 0.2 | ❌ (AWS-specific) |
| 8 | `aws_iam_role` | default | 0.1 | ❌ (AWS-specific) |
| 9 | `kubernetes_cluster` | default | 0.1 | ✅ (cloud-agnostic) |
| 10 | `kubernetes_node_pool` | eks_managed | 0.2 | ✅ (change flavor) |
| 11 | `ingress` | nginx_k8s_native | 0.1 | ✅ (change flavor) |
| 12 | `service` | k8s | 0.1 | ✅ (cloud-agnostic) |
| 13 | `config_map` | k8s | 0.3 | ✅ (cloud-agnostic) |
| 14 | `helm` | helm_simple | null | ✅ (cloud-agnostic) |
| 15 | `log_collector` | loki_aws_s3 | 0.2 | ✅ (change flavor) |
| 16 | `grafana_dashboard` | default | latest | ✅ (cloud-agnostic) |
| 17 | `kubernetes_monitoring` | k8s | 0.1 | ✅ (cloud-agnostic) |
| 18 | `network` | default | 0.1 | ✅ (cloud-agnostic) |

---

## 🔄 How Environment Overrides Work

### Example: PostgreSQL Database

**Blueprint Definition:**
```json
{
  "kind": "postgres",
  "flavor": "rds",
  "version": "0.1",
  "metadata": {"name": "main-db"},
  "spec": {
    "postgres_version": "16",
    "size": {
      "writer": "db.t3.medium"
    }
  }
}
```

**AWS Environment:** No override needed (uses RDS)

**GCP Environment Override:**
```json
{
  "flavor": "gcp_cloudsql",
  "spec": {
    "postgres_version": "16",
    "size": {
      "writer": "db-custom-2-8192"
    }
  }
}
```

Command:
```bash
raptor set resource-overrides \
  --project onelens-clean \
  --environment gcp-production \
  -f gcp-postgres-override.json \
  postgres/main-db
```

---

### Example: Object Storage

**Blueprint Definition:**
```json
{
  "kind": "s3",
  "flavor": "default",
  "version": "0.2",
  "metadata": {"name": "app-storage"},
  "advanced": {
    "s3": {
      "tags": {
        "application": "onyx"
      }
    }
  }
}
```

**AWS Environment:** No override needed (uses S3)

**GCP Environment:** Can't use `s3` kind, must create separate `google_cloud_storage` resource instead.

---

## ⚠️ Challenges with Single Blueprint Approach

### AWS-Specific Resources (Can't Easily Switch)

These resources are AWS-specific and don't have direct GCP mappings in Facets:

1. **s3** → Must use separate `google_cloud_storage` resource for GCP
2. **dynamodb** → Need GCP equivalent (firestore/bigtable)
3. **sqs/sns** → Need GCP equivalent (cloud_pubsub)
4. **iam_policy/aws_iam_role** → Need GCP IAM equivalents

### Recommended Hybrid Approach

**Option 1: Cloud-Specific Resources in Blueprint**
- Define both `s3` AND `google_cloud_storage` in blueprint
- Disable the ones not used per environment
- AWS env: enable s3, disable google_cloud_storage
- GCP env: enable google_cloud_storage, disable s3

**Option 2: Keep AWS Services Even in GCP Environment**
- Use GKE (GCP Kubernetes) but keep AWS DynamoDB, S3, SQS, SNS
- Only migrate: Compute (GKE), Storage (GCS for logs), Database (CloudSQL)
- Cross-cloud architecture (common pattern)

---

## ✅ Recommended Single Blueprint Structure

### Cloud-Agnostic Resources (Define Once)
```
✅ service (33) - k8s | 0.1
✅ config_map (13) - k8s | 0.3
✅ helm (3) - helm_simple
✅ grafana_dashboard (16) - default | latest
✅ kubernetes_monitoring (1) - k8s | 0.1
✅ network (1) - default | 0.1
✅ kubernetes_cluster (1) - default | 0.1
```

### Cloud-Specific Resources (Use Environment Overrides)
```
🔄 postgres (1) - Override flavor: rds → gcp_cloudsql
🔄 kubernetes_node_pool (5) - Override flavor: eks_managed → gke_node_pool
🔄 ingress (5) - Override flavor: aws_alb → gcp_alb
🔄 log_collector (1) - Override flavor: loki_aws_s3 → loki_gcs
🔄 kms (1) - Override flavor: default → gcp_kms
```

### AWS-Only Resources (Conditionally Enable)
```
☁️ s3 (7) - Enable in AWS, disable in GCP
☁️ dynamodb (25) - Enable in AWS, disable in GCP (or keep cross-cloud)
☁️ sqs (7) - Enable in AWS, disable in GCP (or keep cross-cloud)
☁️ sns (3) - Enable in AWS, disable in GCP (or keep cross-cloud)
☁️ iam_policy (3) - Enable in AWS, disable in GCP
☁️ aws_iam_role (5) - Enable in AWS, disable in GCP
```

### GCP-Only Resources (Conditionally Enable)
```
☁️ google_cloud_storage (7) - Disable in AWS, enable in GCP
☁️ [GCP NoSQL] - Disable in AWS, enable in GCP (if available)
☁️ [GCP Pub/Sub] - Disable in AWS, enable in GCP (if available)
```

---

## 📝 Implementation Steps

### Step 1: Create Single Blueprint Project
```bash
raptor create project \
  --name "onelens-multicloud" \
  --description "Multi-cloud blueprint with environment overrides" \
  --project-type default
```

### Step 2: Add Cloud-Agnostic Resources
Add all Kubernetes and observability resources (same for both clouds)

### Step 3: Add AWS-Specific Resources
Add with AWS flavors as defaults

### Step 4: Add GCP-Specific Resources
Add as disabled by default

### Step 5: Create AWS Environment
```bash
raptor create environment \
  --project onelens-multicloud \
  --name aws-production \
  --cloud aws
```

Enable: s3, dynamodb, sqs, sns, iam, eks
Disable: google_cloud_storage, gcp services

### Step 6: Create GCP Environment
```bash
raptor create environment \
  --project onelens-multicloud \
  --name gcp-production \
  --cloud gcp
```

Enable: google_cloud_storage, gcp services
Disable: s3, dynamodb, sqs, sns (or keep cross-cloud)

Add overrides for:
- postgres (flavor: gcp_cloudsql)
- kubernetes_node_pool (flavor: gke_node_pool)
- ingress (flavor: gcp_alb)

---

## 🎯 Final Resource Type List for Single Blueprint

### Include All These (18 types)

| Resource Type | Flavor | Version | Notes |
|--------------|--------|---------|-------|
| `service` | k8s | 0.1 | Cloud-agnostic |
| `postgres` | rds | 0.1 | Override flavor per env |
| `s3` | default | 0.2 | AWS only |
| `google_cloud_storage` | default | 0.1 | GCP only (disabled by default) |
| `dynamodb` | astuto-dynamodb | 0.1 | AWS only (or cross-cloud) |
| `sqs` | default | 0.2 | AWS only (or cross-cloud) |
| `sns` | default | 0.1 | AWS only (or cross-cloud) |
| `kms` | default | 0.1 | Override flavor per env |
| `iam_policy` | aws_iam_policy | 0.2 | AWS only |
| `aws_iam_role` | default | 0.1 | AWS only |
| `kubernetes_cluster` | default | 0.1 | Cloud-agnostic |
| `kubernetes_node_pool` | eks_managed | 0.2 | Override flavor per env |
| `ingress` | nginx_k8s_native | 0.1 | Override flavor per env |
| `config_map` | k8s | 0.3 | Cloud-agnostic |
| `helm` | helm_simple | null | Cloud-agnostic |
| `log_collector` | loki_aws_s3 | 0.2 | Override flavor per env |
| `grafana_dashboard` | default | latest | Cloud-agnostic |
| `kubernetes_monitoring` | k8s | 0.1 | Cloud-agnostic |
| `network` | default | 0.1 | Cloud-agnostic |

**Total: 19 resource types (some disabled per environment)**
