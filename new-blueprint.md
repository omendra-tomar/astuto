# New Blueprint Plan - Clean Architecture

## Goal
Create a **clean, lean blueprint** with only actively used resource types, organized for cost attribution via mandatory tags.

---

## 🎯 Blueprint Resource Types to Include

Based on the cleanup analysis, here are the resource types you should add to your new blueprint:

---

## 1️⃣ CORE APPLICATION LAYER (Priority: Critical)

### Services / Applications
**Resource Type:** `service`
**Flavors:** `k8s`, `deployment`
**Count Needed:** 33 services
**Purpose:** Core application workloads (Onyx workflow engine, Onelens platform)

**Applications:**
- Onyx: 28 services (workflow, integrations, dashboard, etc.)
- Onelens: 2 services (backend, platform)
- Shared: 3 services (policy-master-tool, data-harvest, etc.)

**Why Keep:** Active business logic and application runtime

---

## 2️⃣ DATA STORAGE LAYER (Priority: Critical)

### DynamoDB (NoSQL Database)
**Resource Type:** `dynamodb`
**Flavor:** `astuto-dynamodb`
**Version:** `0.1`
**Count Needed:** 25 tables
**Tagging:** ✅ Supports `spec.tags`

**Purpose:** Primary data storage for Onyx application
**Why Keep:** Active database layer with high usage

---

### PostgreSQL (Relational Database)
**Resource Type:** `postgres`
**Flavor:** `rds` (AWS) or `gcp_cloudsql` (GCP)
**Version:** `0.1`
**Count Needed:** 1 database
**Tagging:** Test `advanced.rds.tags`

**Purpose:** Dagster orchestration database
**Why Keep:** Required for workflow orchestration
**Note:** May need flavor change per cleanup report

---

## 3️⃣ OBJECT STORAGE LAYER (Priority: Critical)

### S3 (AWS Object Storage)
**Resource Type:** `s3`
**Flavor:** `default`
**Version:** `0.2`
**Count Needed:** 7 buckets
**Tagging:** ✅ Supports `advanced.s3.tags`

**Purpose:** File storage for workflows, logs, backups, tenant data
**Why Keep:** Active storage layer

---

### Google Cloud Storage (GCP Object Storage)
**Resource Type:** `google_cloud_storage`
**Flavor:** `default`
**Version:** `0.1`
**Count Needed:** 0-2 buckets (enable if migrating to GCP)
**Tagging:** ✅ Supports `metadata.labels`

**Purpose:** S3 alternative for multi-cloud strategy
**Why Keep:** Future GCP migration path

---

## 4️⃣ MESSAGING LAYER (Priority: Critical)

### SQS (Message Queues)
**Resource Type:** `sqs`
**Flavor:** `default`
**Version:** `0.2`
**Count Needed:** 7 queues
**Tagging:** Test `advanced.sqs.tags`

**Purpose:** Async message processing for Onyx workflows
**Why Keep:** Core to event-driven architecture

---

### SNS (Pub/Sub Notifications)
**Resource Type:** `sns`
**Flavor:** `default`
**Version:** `0.1`
**Count Needed:** 3 topics
**Tagging:** Test `advanced.sns.tags`

**Purpose:** Event notifications and alerts
**Why Keep:** Core to notification system

---

## 5️⃣ SECURITY LAYER (Priority: Critical)

### IAM Policies
**Resource Type:** `iam_policy`
**Flavor:** `aws_iam_policy`
**Count Needed:** 3 policies
**Tagging:** Check schema

**Purpose:** Access control policies
**Why Keep:** Required for secure access

---

### IAM Roles
**Resource Type:** `iam_role`
**Flavor:** `default`
**Count Needed:** 5 roles
**Tagging:** Check schema

**Purpose:** Service authentication and authorization
**Why Keep:** Critical for security model

---

### KMS (Encryption Keys)
**Resource Type:** `kms`
**Flavor:** `default`
**Version:** `0.1`
**Count Needed:** 1 key
**Tagging:** Test `advanced.kms.tags`

**Purpose:** Encryption key management
**Why Keep:** Data encryption requirements

---

## 6️⃣ KUBERNETES INFRASTRUCTURE (Priority: High)

### Kubernetes Cluster
**Resource Type:** `kubernetes_cluster`
**Flavor:** `eks` (AWS) or `gke` (GCP)
**Count Needed:** 1 cluster
**Tagging:** K8s labels

**Purpose:** Container orchestration platform
**Why Keep:** Core infrastructure for all services

---

### Kubernetes Node Pools
**Resource Type:** `kubernetes_node_pool`
**Flavor:** Various
**Count Needed:** 2-5 active pools (review 22 existing)
**Tagging:** K8s labels

**Purpose:** Compute capacity for workloads
**Why Keep:** Required for running containers
**Action:** Review and keep only active node pools

---

### Ingress Controllers
**Resource Type:** `ingress`
**Flavor:** `nginx`, `nlb`, etc.
**Count Needed:** 4-5 controllers
**Tagging:** K8s labels

**Purpose:** External access to services
**Why Keep:** Required for inbound traffic
**Note:** May need flavor changes per report

---

## 7️⃣ OBSERVABILITY LAYER (Priority: High)

### Loki (Log Aggregation)
**Resource Type:** `log_collector`
**Flavor:** Based on Loki
**Count Needed:** 1
**Tagging:** K8s labels

**Purpose:** Centralized logging (replaces Elasticsearch)
**Why Keep:** Active logging solution

---

### Promtail (Log Shipping)
**Resource Type:** (Check if separate resource)
**Count Needed:** 1
**Tagging:** K8s labels

**Purpose:** Log collection agent
**Why Keep:** Feeds Loki

---

### Grafana Dashboards
**Resource Type:** `grafana_dashboard`
**Flavor:** `default`
**Count Needed:** 16 dashboards
**Tagging:** Not directly tagged

**Purpose:** Monitoring and visualization
**Why Keep:** Observability and alerting

---

### Monitoring Stack
**Resource Type:** `monitoring`
**Flavor:** `default`
**Count Needed:** 1
**Tagging:** K8s labels

**Purpose:** Metrics collection
**Why Keep:** Infrastructure monitoring

---

## 8️⃣ CONFIGURATION LAYER (Priority: Medium)

### ConfigMaps
**Resource Type:** `configmap`
**Flavor:** `k8s`
**Count Needed:** 13 configmaps
**Tagging:** K8s labels

**Purpose:** Application configuration storage
**Why Keep:** Required for service configuration

---

### Keda (Event-Driven Autoscaling)
**Resource Type:** Part of K8s resources
**Count Needed:** 1
**Tagging:** K8s labels

**Purpose:** Auto-scaling based on queue depth
**Why Keep:** Active, but moving away from shared ConfigMap

---

## 9️⃣ ORCHESTRATION LAYER (Priority: Medium)

### Helm Releases
**Resource Type:** `helm`
**Count Needed:** 3 active releases
**Tagging:** K8s labels

**Resources:**
- k8s-dashboard
- dagster-daemon
- dagster-webserver

**Purpose:** Package management for K8s
**Why Keep:** Simplified deployment management

---

## 🔟 NETWORK LAYER (Priority: Low)

### Network
**Resource Type:** `network`
**Flavor:** `default`
**Count Needed:** 1
**Tagging:** Cloud tags

**Purpose:** VPC/Network infrastructure
**Why Keep:** Foundation for all resources

---

## ⚠️ CONDITIONAL / NEEDS CONFIRMATION

### EventBridge (AWS Event Bus)
**Resource Type:** `eventbridge`
**Flavor:** `default`
**Version:** `0.1`
**Count Needed:** 1
**Tagging:** Test `advanced.eventbridge.tags`

**Purpose:** Event-driven workflow triggers
**Why Keep:** ⚠️ CONFIRM WITH CLEMENT
**Action:** Keep if confirmed, remove if unused

---

## ❌ RESOURCE TYPES TO EXCLUDE FROM NEW BLUEPRINT

### DO NOT Include These:

1. ❌ **Cognito** (`cognito`) - No longer required
2. ❌ **EFS** (`aws_efs`) - Replaced by GCP alternative
3. ❌ **OpenSearch/Elasticsearch** (`opensearch`) - Replaced by Loki + Promtail + GCS
4. ❌ **Amplify** - Already migrated away
5. ❌ **Batch** - Already handled
6. ❌ **CloudWatch Alerts** - No longer used
7. ❌ **Lambda** - not sure

---

## 📊 NEW BLUEPRINT SUMMARY

### Resource Types by Layer

| Layer | Resource Types | Count | Priority |
|-------|---------------|-------|----------|
| **Application** | service | 33 | Critical |
| **Data Storage** | dynamodb, postgres | 26 | Critical |
| **Object Storage** | s3, google_cloud_storage | 7 | Critical |
| **Messaging** | sqs, sns | 10 | Critical |
| **Security** | iam_policy, iam_role, kms | 9 | Critical |
| **Kubernetes** | cluster, node_pool, ingress | 25 | High |
| **Observability** | log_collector, grafana_dashboard, monitoring | 18 | High |
| **Configuration** | configmap, helm | 16 | Medium |
| **Network** | network | 1 | Low |
| **Conditional** | eventbridge | 1 | Confirm |
| **Total** | 18-19 resource types | ~146 | - |

---

## 🏗️ BLUEPRINT ARCHITECTURE LAYERS

```
┌─────────────────────────────────────────────────────────────┐
│                    APPLICATION LAYER                        │
│  service (k8s, deployment) - 33 services                    │
│  - Onyx: workflow, integrations, dashboard                  │
│  - Onelens: backend, platform                               │
└─────────────────────────────────────────────────────────────┘
                           ↓ depends on
┌─────────────────────────────────────────────────────────────┐
│                    DATA LAYER                               │
│  dynamodb (25 tables) + postgres (1 db)                     │
│  s3 (7 buckets) + google_cloud_storage (optional)           │
└─────────────────────────────────────────────────────────────┘
                           ↓ uses
┌─────────────────────────────────────────────────────────────┐
│                    MESSAGING LAYER                          │
│  sqs (7 queues) + sns (3 topics)                            │
└─────────────────────────────────────────────────────────────┘
                           ↓ secured by
┌─────────────────────────────────────────────────────────────┐
│                    SECURITY LAYER                           │
│  iam_policy (3) + iam_role (5) + kms (1)                    │
└─────────────────────────────────────────────────────────────┘
                           ↓ runs on
┌─────────────────────────────────────────────────────────────┐
│                    INFRASTRUCTURE LAYER                     │
│  kubernetes_cluster (1) + node_pool (5) + ingress (5)       │
│  network (1)                                                │
└─────────────────────────────────────────────────────────────┘
                           ↓ monitored by
┌─────────────────────────────────────────────────────────────┐
│                    OBSERVABILITY LAYER                      │
│  log_collector (Loki) + grafana_dashboard (16)              │
│  monitoring (1)                                             │
└─────────────────────────────────────────────────────────────┘
                           ↓ configured via
┌─────────────────────────────────────────────────────────────┐
│                    CONFIGURATION LAYER                      │
│  configmap (13) + helm (3)                                  │
└─────────────────────────────────────────────────────────────┘
```

---

## 🏷️ MANDATORY TAGS FOR ALL RESOURCES

Every resource in the new blueprint must have:

```json
{
  "customer": "customer-name",
  "environment": "production",
  "project": "onelens",
  "team": "onyx-team",
  "application": "onyx"
}
```

**AWS Resources:** Use `advanced.<service>.tags` or `spec.tags`
**GCP Resources:** Use `metadata.labels`
**K8s Resources:** Use `metadata.labels`

---

## 🎯 BLUEPRINT CREATION STEPS

### Step 1: Create New Project
```bash
# Create new project with clean blueprint
raptor create project \
  --name "onelens-clean-4786099461" \
  --description "Clean blueprint with only active resources" \
  --project-type default
```

### Step 2: Define Resource Types to Include

Create a checklist of resource types to add:

#### Critical (Add First)
- [ ] service (33 instances)
- [ ] dynamodb (25 instances)
- [ ] s3 (7 instances)
- [ ] sqs (7 instances)
- [ ] sns (3 instances)
- [ ] iam_policy (3 instances)
- [ ] iam_role (5 instances)
- [ ] kms (1 instance)

#### High Priority (Add Second)
- [ ] kubernetes_cluster (1 instance)
- [ ] kubernetes_node_pool (5 instances - review)
- [ ] ingress (5 instances)
- [ ] postgres (1 instance)
- [ ] log_collector (1 instance - Loki)
- [ ] grafana_dashboard (16 instances)
- [ ] monitoring (1 instance)

#### Medium Priority (Add Third)
- [ ] configmap (13 instances)
- [ ] helm (3 instances)
- [ ] network (1 instance)

#### Conditional
- [ ] eventbridge (1 instance - confirm first)
- [ ] google_cloud_storage (0-2 instances - if migrating)

### Step 3: Add Resources with Tags

For each resource type, create resources with mandatory tags:

**Example: DynamoDB**
```bash
cat > onyx-request-db.json <<'EOF'
{
  "kind": "dynamodb",
  "flavor": "astuto-dynamodb",
  "version": "0.1",
  "metadata": {"name": "onyx-request-db"},
  "spec": {
    "hash_key": "id",
    "tags": {
      "customer": "customer-name",
      "environment": "production",
      "project": "onelens",
      "team": "onyx-team",
      "application": "onyx"
    }
  }
}
EOF

raptor apply -f onyx-request-db.json --project onelens-clean-4786099461
```

**Example: S3**
```bash
cat > onyx-backend-s3.json <<'EOF'
{
  "kind": "s3",
  "flavor": "default",
  "version": "0.2",
  "metadata": {"name": "onyx-backend"},
  "advanced": {
    "s3": {
      "tags": {
        "customer": "customer-name",
        "environment": "production",
        "project": "onelens",
        "team": "onyx-team",
        "application": "onyx"
      }
    }
  }
}
EOF

raptor apply -f onyx-backend-s3.json --project onelens-clean-4786099461
```

### Step 4: Create Environments

```bash
# Create production environment
raptor create environment \
  --project onelens-clean-4786099461 \
  --name production \
  --cloud aws

# Create GCP environment (if needed)
raptor create environment \
  --project onelens-clean-4786099461 \
  --name prod-gcp \
  --cloud gcp
```

### Step 5: Deploy and Verify

```bash
# Deploy to production
raptor create release \
  --project onelens-clean-4786099461 \
  --environment production \
  -w

# Verify tags in AWS
aws resourcegroupstaggingapi get-resources \
  --tag-filters Key=customer \
  --output table
```

---

## 📋 RESOURCE TYPE CHECKLIST

### Include in New Blueprint ✅

| Resource Type | Flavor | Version | Count | Tagging Method |
|--------------|--------|---------|-------|----------------|
| service | k8s, deployment | 0.2 | 33 | K8s labels |
| dynamodb | astuto-dynamodb | 0.1 | 25 | `spec.tags` |
| s3 | default | 0.2 | 7 | `advanced.s3.tags` |
| sqs | default | 0.2 | 7 | `advanced.sqs.tags` |
| sns | default | 0.1 | 3 | `advanced.sns.tags` |
| iam_policy | aws_iam_policy | - | 3 | Check schema |
| iam_role | default | - | 5 | Check schema |
| kms | default | 0.1 | 1 | `advanced.kms.tags` |
| kubernetes_cluster | eks/gke | - | 1 | K8s labels |
| kubernetes_node_pool | various | - | 5 | K8s labels |
| ingress | nginx, nlb | - | 5 | K8s labels |
| postgres | rds/gcp_cloudsql | 0.1 | 1 | `advanced.rds.tags` |
| log_collector | loki | - | 1 | K8s labels |
| grafana_dashboard | default | latest | 16 | N/A |
| monitoring | default | - | 1 | K8s labels |
| configmap | k8s | - | 13 | K8s labels |
| helm | various | - | 3 | K8s labels |
| network | default | - | 1 | Cloud tags |
| eventbridge | default | 0.1 | 1? | `advanced.eventbridge.tags` |
| google_cloud_storage | default | 0.1 | 0-2 | `metadata.labels` |

### Exclude from New Blueprint ❌

- ❌ cognito
- ❌ aws_efs
- ❌ opensearch
- ❌ amplify
- ❌ batch
- ❌ cloudwatch_alert
- ❌ lambda

---

## Next Steps

Would you like me to:

1. **Create a script to generate all resource JSONs** with mandatory tags for the new blueprint?
2. **Generate Raptor commands** to create the new project and add all resources?
3. **Create a migration plan** from old blueprint to new clean blueprint?
4. **Build resource dependency graph** to show the correct order of creation?
