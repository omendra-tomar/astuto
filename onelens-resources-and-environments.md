# OneLens Platform - Resources & Running Environments
## Complete Technical Inventory

**Project:** onelens-4786099461
**Date:** 2025-12-16
**Total Resources Defined:** 149
**Active Resources:** ~100
**Multi-Cloud:** AWS (Primary) + GCP (Expansion)

---

## 📊 RUNNING ENVIRONMENTS

### Environment Overview

| Environment | Cloud Provider | Region Type | Cluster State | Release Stream | Last Deploy | Status | Notes |
|------------|----------------|-------------|---------------|----------------|-------------|---------|-------|
| **prod** | AWS | Primary | RUNNING | PROD | 2025-12-16 09:00 | ✅ SUCCESS | Production AWS |
| **prod-gcp** | GCP | Primary | RUNNING | PROD | 2025-12-16 12:32 | 🔄 IN_PROGRESS | GCP production |
| **test-gcp** | GCP | Primary | RUNNING | DEV | 2025-12-16 12:27 | ✅ SUCCESS | GCP development |
| **test** | AWS | Primary | RUNNING | QA | 2025-11-26 12:26 | ⚠️ FAILED | QA environment |
| **dev** | AWS | Primary | DESTROY_FAILED | DEV | 2025-08-26 11:26 | ❌ FAILED | Development |
| **prod-us** | AWS | US Region | DESTROY_FAILED | PROD1 | 2025-08-29 07:04 | ❌ N/A | Multi-region attempt |

### Environment Details

#### prod (AWS Production)
```yaml
Environment ID: 67d7af3975d2f000071e7514
Cloud: AWS
Release Stream: PROD
GitOps: Enabled
Last Modified: 2025-11-11T11:28:04.145+00:00
Last Modified By: clement@astuto.ai
Status: Fully operational, active production
```

#### prod-gcp (GCP Production)
```yaml
Environment ID: 688124799c4d5f6c42e1b8f8
Cloud: GCP
Release Stream: PROD
GitOps: Enabled
Last Modified: 2025-12-16T07:05:12.781+00:00
Last Modified By: devops@astuto.ai
Status: Active deployment in progress
```

#### test-gcp (GCP Testing)
```yaml
Environment ID: 6883cf3f9a5978501f76c153
Cloud: GCP
Release Stream: DEV
GitOps: Enabled
Last Modified: 2025-11-11T11:28:05.177+00:00
Last Modified By: clement@astuto.ai
Status: Stable, successful deployment
```

#### test (AWS QA)
```yaml
Environment ID: 67c14bcbaaaa7200076a6c48
Cloud: AWS
Release Stream: QA
GitOps: Enabled
Last Modified: 2025-11-11T11:28:03.806+00:00
Last Modified By: clement@astuto.ai
Status: Running but last deployment failed
```

---

## 🗄️ DATABASE RESOURCES (26 Total)

### DynamoDB Tables (25 Active)

All DynamoDB tables use **astuto-dynamodb** flavor, version **0.1**

#### Workflow Domain (8 tables)
```
1. onyx-workflow-db
   Purpose: Core workflow definitions and metadata

2. onyx-workflow-execution-db
   Purpose: Workflow execution history and state

3. onyx-workflow-trigger-db
   Purpose: Workflow trigger definitions

4. onyx-workflow-settings-db
   Purpose: Workflow configuration settings

5. onyx-workflow-audit-db
   Purpose: Audit trail for workflow changes

6. onyx-workflow-version-db
   Purpose: Workflow versioning information

7. onyx-workflow-global-trigger-db
   Purpose: Global trigger definitions

8. onyx-request-db
   Purpose: Request tracking and processing
```

#### Runbooks Domain (7 tables)
```
9. onyx-global-runbooks-db
   Purpose: Global runbook templates

10. onyx-tenant-runbooks-db
    Purpose: Tenant-specific runbooks

11. onyx-tenant-runbook-execution-db
    Purpose: Runbook execution history

12. onyx-tenant-runbook-audit-db
    Purpose: Runbook execution audit trail

13. onyx-tenant-runbook-execution-counter-db
    Purpose: Runbook execution metrics

14. onyx-tenant-runbook-account-mapping-db
    Purpose: Account mapping for runbooks

15. onyx-global-runbook-recommendation-db
    Purpose: Runbook recommendations engine
```

#### Integrations Domain (5 tables)
```
16. onyx-global-integration-db
    Purpose: Global integration definitions

17. onyx-tenant-integration-db
    Purpose: Tenant-specific integrations

18. onyx-tenant-integration-credentials-db
    Purpose: Encrypted integration credentials

19. onyx-tenant-integration-audit-db
    Purpose: Integration usage audit trail

20. onyx-global-integration-action-config-db
    Purpose: Integration action configurations
```

#### Tenant & Auth Domain (4 tables)
```
21. onyx-tenant-db
    Purpose: Tenant master data

22. onyx-auth-sso-tenant-mapping-db
    Purpose: SSO to tenant mapping

23. onyx-notification-rate-limit-db
    Purpose: Notification rate limiting

24. onyx-request-db
    Purpose: Request processing and tracking
```

### PostgreSQL (1 Active)
```
25. dagster-db
    Resource ID: postgres/dagster-db
    Flavor: rds
    Version: 0.1
    Purpose: Dagster metadata storage and job orchestration
    Used By:
      - dagster-daemon
      - dagster-webserver
      - onyx-authentication-api (connection string injection)
```

### OpenSearch (1 Active)
```
26. logs
    Resource ID: elasticsearch/logs
    Flavor: opensearch
    Version: 0.2
    Purpose: Advanced log search and analytics
    Integration: Receives logs from Loki for searchability
```

---

## 🚀 MICROSERVICES (56 Total, 44 Active)

### Active Services (44)

#### Authentication Services (1)
```
1. onyx-authentication-api
   Flavor: deployment
   Version: 0.1
   Dependencies:
     - postgres/dagster-db (database)
     - config_map/onyx-authentication
     - aws_iam_role/onyx-role
   Purpose: User authentication and SSO management
```

#### Workflow Services (6)
```
2. onyx-workflow-mgmt-api
   Flavor: deployment
   Dependencies: config_map/onyx-wf-mgmt, aws_iam_role/onyx-role
   Purpose: Workflow management API

3. onyx-workflow-actions-api
   Flavor: deployment
   Dependencies: config_map/onyx-wf-actions
   Purpose: Workflow actions execution

4. onyx-workflow-execution-job
   Flavor: deployment
   Dependencies: sqs/onyx-workflow-execution, config_map/onyx-wf-execution
   Purpose: Background workflow executor

5. onyx-workflow-trigger-job
   Flavor: deployment
   Dependencies: sqs/onyx-workflow-trigger
   Purpose: Workflow trigger processor

6. onyx-workflow-cron-job
   Flavor: deployment
   Dependencies: sqs/onyx-workflow-cron
   Purpose: Scheduled workflow execution

7. onyx-scheduler-api
   Flavor: deployment
   Dependencies: config_map/onyx-scheduler
   Purpose: Workflow scheduling
```

#### Runbooks Services (1)
```
8. onyx-runbooks-api
   Flavor: deployment
   Dependencies: config_map/runbooks-api-config
   Purpose: Runbook management and execution
```

#### Integration Services (1)
```
9. onyx-integrations-api
   Flavor: deployment
   Dependencies: config_map/onyx-integrations
   Purpose: Third-party integrations management
```

#### Request Processing Services (3)
```
10. onyx-request-processor-api
    Flavor: deployment
    Purpose: Request API endpoint

11. onyx-request-processor-job
    Flavor: deployment
    Dependencies: sqs/onyx-request-processor, config_map/onyx-request-proc
    Purpose: Background request processor

12. data-harvest
    Flavor: deployment
    Purpose: Data collection and harvesting
```

#### Data Warehouse & Analytics Services (4)
```
13. onyx-dataware-house-api
    Flavor: deployment
    Dependencies: config_map/onyx-dwh
    Purpose: Data warehouse query API

14. onyx-dataware-house-api-temp
    Flavor: deployment
    Purpose: Temporary data warehouse API (migration)

15. onyx-dataware-house-job
    Flavor: deployment
    Purpose: Data warehouse background jobs

16. onyx-dashboard-api
    Flavor: deployment
    Dependencies: config_map/onyx-dashboard
    Purpose: Dashboard data API
```

#### Cost Management Services (2)
```
17. onyx-cost-center-api
    Flavor: deployment
    Dependencies: config_map/onyx-cost-center
    Purpose: Cost analysis API

18. onyx-cost-center-job
    Flavor: deployment
    Purpose: Cost data processing jobs
```

#### AI & Insights Services (2)
```
19. onyx-ai-insights-api
    Flavor: deployment
    Purpose: AI-powered insights and predictions

20. policy-master-tool
    Flavor: deployment
    Purpose: Policy management and recommendations
```

#### Log Processing Services (1)
```
21. onyx-log-processor-job
    Flavor: deployment
    Dependencies: sqs/onyx-log-processor
    Purpose: Log aggregation and processing
```

#### Core Backend Services (1)
```
22. onelens-backend
    Flavor: k8s (special)
    Version: 0.1
    Purpose: Main OneLens backend service
```

### Disabled Services (12)
```
❌ tenant-management (deployment, disabled)
❌ tenant-mgmt-svc (deployment, disabled)
❌ onelens-be-preprod (deployment, disabled)
❌ onelens-o11y (deployment, disabled)
❌ onelens-alerts (cronjob, disabled)
❌ websearch (deployment, disabled)
❌ ask-navira (deployment, disabled)
❌ memgraph-db (deployment, disabled)
❌ memgraph-lab (deployment, disabled)
❌ cloudsql-auth-proxy (deployment, disabled)
❌ ol-sch-handler (lambda, disabled)
```

---

## 📬 MESSAGING & EVENT RESOURCES

### SQS Queues (8 Total, 7 Active)

All queues use **default** flavor, version **0.2**

```
1. onyx-workflow-execution
   Purpose: Workflow execution task queue
   Consumer: onyx-workflow-execution-job

2. onyx-workflow-trigger
   Purpose: Workflow trigger event queue
   Consumer: onyx-workflow-trigger-job

3. onyx-workflow-cron
   Purpose: Scheduled workflow queue
   Consumer: onyx-workflow-cron-job

4. onyx-request-processor
   Purpose: Request processing queue
   Consumer: onyx-request-processor-job

5. onyx-log-processor
   Purpose: Log processing queue
   Consumer: onyx-log-processor-job

6. onyx-orchestrator
   Purpose: General orchestration queue

7. olschedulerdlq
   Purpose: Scheduler dead letter queue

8. onyx-workflow-dlq
   Purpose: Workflow dead letter queue

❌ onyx-cur-delta (disabled)
   Purpose: Cost & Usage Report delta processing
```

### SNS Topics (3 Active)

All topics use **default** flavor, version **0.1**

```
1. onyx-workflow-execution
   Purpose: Workflow execution events
   Subscribers: sqs/onyx-workflow-execution

2. onyx-workflow-trigger
   Purpose: Workflow trigger events
   Subscribers: sqs/onyx-workflow-trigger

3. onyx-notification
   Purpose: General notification events
   Subscribers: Multiple services
```

### AWS EventBridge (1 Active)
```
onyx-workflow-execution
  Flavor: default
  Version: 0.1
  Purpose: Event-driven workflow triggering
  Flow: EventBridge → SNS → SQS → Service Jobs
```

---

## 💾 STORAGE RESOURCES

### S3 Buckets (7 Active)

All buckets use **default** flavor, version **0.2**

```
1. onyx-workflow
   Purpose: Workflow artifacts and execution data

2. onyx-backend
   Purpose: Backend application assets

3. onelens-data
   Purpose: Application data storage

4. onelens-downloads
   Purpose: User download files

5. onelens-tenants-cur
   Purpose: AWS Cost & Usage Reports per tenant

6. loki-s3
   Purpose: Loki log long-term storage

7. kubernetes-s3-bucket
   Purpose: Kubernetes manifests and configs
```

### AWS EFS (1 Active)
```
dagster-efs
  Flavor: default
  Version: 0.1
  Purpose: Shared persistent storage for Dagster jobs
  Mounted By: dagster-daemon, dagster-webserver
```

### GCS Buckets (2 Disabled)
```
❌ tenant-cur (GCS, disabled)
❌ loki-gcs (GCS, disabled)
```

### KMS Encryption (1 Active)
```
onelens-key
  Flavor: default
  Version: 0.1
  Purpose: Encryption key for data at rest
  Scope: DynamoDB, S3, EFS, RDS
```

---

## ⚙️ CONFIGURATION RESOURCES

### ConfigMaps (13 Total, 12 Active)

All ConfigMaps use **k8s** flavor, version **0.3**

```
1. onyx-authentication
   Used By: onyx-authentication-api

2. onyx-wf-mgmt
   Used By: onyx-workflow-mgmt-api

3. onyx-wf-actions
   Used By: onyx-workflow-actions-api

4. onyx-wf-execution
   Used By: onyx-workflow-execution-job

5. onyx-integrations
   Used By: onyx-integrations-api

6. runbooks-api-config
   Used By: onyx-runbooks-api

7. onyx-dashboard
   Used By: onyx-dashboard-api

8. onyx-dwh
   Used By: onyx-dataware-house-api, onyx-dataware-house-job

9. onyx-cost-center
   Used By: onyx-cost-center-api, onyx-cost-center-job

10. onyx-request-proc
    Used By: onyx-request-processor-job

11. onyx-scheduler
    Used By: onyx-scheduler-api

12. dagster-job-config
    Used By: Dagster jobs

❌ onelens-alerts-cm (disabled)
```

### Platform Configurations (8 Total, 7 Active)

```
1. eks_addon
   Flavor: default
   Version: 0.2
   Purpose: AWS EKS add-ons configuration

2. vpa
   Version: 0.1
   Purpose: Vertical Pod Autoscaler

3. keda
   Version: 0.1
   Purpose: Kubernetes Event-Driven Autoscaler

4. prometheus
   Version: latest
   Purpose: Metrics collection configuration

5. alb
   Purpose: AWS Application Load Balancer controller

6. cluster-autoscalar
   Flavor: default
   Version: 0.1
   Purpose: Node autoscaling

7. cert-manager
   Purpose: TLS certificate management

❌ wireguard_operator (version 0.1, disabled)
```

---

## 🌐 NETWORKING RESOURCES

### Ingress Resources (7 Total, 4 Active)

#### AWS Ingress (3 Total, 2 Active)
```
1. public-ingress ✅
   Flavor: aws_alb
   Version: 0.2
   Purpose: Public-facing ALB for external APIs
   Routes: onyx-* APIs

2. dagster ✅
   Flavor: aws_alb
   Version: 0.2
   Purpose: Dagster web interface
   Auth: AWS Cognito OIDC

❌ private-ingress
   Flavor: aws_alb
   Version: 0.2
   Status: Disabled
```

#### GCP Ingress (2 Total, 1 Active)
```
3. public-nlb-ingress ✅
   Flavor: gcp_alb
   Version: 0.2
   Purpose: GCP public load balancer

❌ gcp-public-alb
   Flavor: gcp_alb
   Version: 0.2
   Status: Disabled
```

#### NGINX Ingress (2 Total, 1 Active)
```
4. tools ✅
   Flavor: nginx_k8s_native
   Version: 0.1
   Purpose: Internal tools and dashboards

❌ private-nlb-ingress
   Flavor: nginx_k8s_native
   Version: 0.1
   Status: Disabled
```

### Network (1 Active)
```
default
  Flavor: default
  Version: 0.1
  Purpose: VPC configuration
  Components:
    - VPC
    - Public/Private Subnets
    - NAT Gateways
    - Security Groups
    - Route Tables
```

---

## ☸️ KUBERNETES RESOURCES

### Kubernetes Cluster (1 Active)
```
default
  Flavor: default
  Version: 0.1
  Multi-Cloud: EKS (AWS) + GKE (GCP)
  Orchestration: Facets-managed
```

### Node Pools (14 Total, 1 Active)

#### AWS EKS Node Pools (4 Total, 1 Active)
```
1. jobs-node ✅
   Flavor: eks_self_managed
   Version: 0.1
   Purpose: Background job workloads
   Status: Active

❌ ol-medium (eks_self_managed, v0.1, disabled)
❌ ol-large (eks_self_managed, v0.1, disabled)
❌ manoj-to-de-delete (eks_managed, v0.2, disabled)
```

#### GCP GKE Node Pools (8 Total, 0 Active)
```
All GCP node pools are DISABLED:
❌ default-arm (gke_node_pool, v0.1)
❌ ol-arm-medium (gke_node_pool, v0.1)
❌ ol-arm-mini (gke_node_pool, v0.1)
❌ ol-arm-small (gke_node_pool, v0.1)
❌ onyx-amd-np (gke_node_pool, v0.1)
❌ arm-node-1c (gke_node_pool, v0.1)
❌ core-amd-np (gke_node_pool, v0.1)
❌ dagster-np (gke_node_pool, v0.1)
❌ gcp-arm-based (gke_node_pool, v0.1)
```

#### Multi-Cloud Node Fleets (2 Total, 0 Active)
```
❌ onyx-nodepool (node_fleet, v0.1, disabled)
❌ onyx-nodepool-gcp (node_fleet, v0.1, disabled)
```

### Kubernetes Resources (5 Total, 1 Active)

```
1. public-nlb-backend-config ✅
   Flavor: default
   Version: latest
   Purpose: Backend configuration for GCP load balancer

❌ ecs-task-exec-sa (k8s, v0.3, disabled)
❌ efs-sc-2 (k8s, v0.3, disabled)
❌ dagster-daemon-pvc (k8s, v0.3, disabled)
❌ dagster-web-pvc (k8s, v0.3, disabled)
```

### Kubernetes Secrets (1 Total, 0 Active)
```
❌ cognito-oidc-secret
   Flavor: k8s
   Version: 0.3
   Purpose: Cognito OIDC authentication secrets
   Status: Disabled
```

---

## 🔐 IAM & SECURITY RESOURCES

### IAM Roles (5 Active)

All roles use **default** flavor, version **0.1**

```
1. onyx-role
   Purpose: Primary service account role for all onyx-* services
   Used By: All microservices in onyx namespace
   Permissions: Via IRSA (IAM Roles for Service Accounts)
   Attached Policies:
     - onyx-permissions
     - CloudWatchLogsFullAccess

2. keda-role
   Purpose: KEDA autoscaler permissions
   Used By: KEDA controller
   Permissions: SQS queue metrics, scaling decisions

3. full-services-access
   Purpose: Full service access role
   Scope: Administrative operations

4. ol-sch-handler
   Purpose: Lambda execution role
   Used By: ol-sch-handler Lambda (disabled)

5. onyx-workflow-step-function-role
   Purpose: Step Functions execution role
   Used By: AWS Step Functions for workflow orchestration
```

### IAM Policies (3 Active)

All policies use **aws_iam_policy** flavor, version **0.2**

```
1. onyx-permissions
   Purpose: Custom permissions for onyx services
   Attached To: onyx-role
   Permissions:
     - DynamoDB access (25 tables)
     - S3 access (7 buckets)
     - SQS access (8 queues)
     - SNS publish

2. full-services-access
   Purpose: Full service permissions
   Attached To: full-services-access role

3. ol-sch-handler
   Purpose: Lambda execution permissions
   Attached To: ol-sch-handler role
```

### AWS Cognito (2 Total, 1 Active)

```
1. dagster-access ✅
   Flavor: astuto-default
   Version: 0.1
   Purpose: Dagster web UI authentication
   Integration: OIDC with ingress/dagster

❌ dagster
   Flavor: default
   Version: 0.1
   Status: Disabled (replaced by dagster-access)
```

---

## 📊 OBSERVABILITY RESOURCES

### Grafana Dashboards (16 Total, 15 Active)

All dashboards use **default** flavor, version **latest**

#### Application Dashboards (4)
```
1. application-dashboard ✅
   Purpose: Overall application metrics

2. application-resource-summary ✅
   Purpose: Resource usage by application

3. app-usage-summary ✅
   Purpose: Application usage statistics

4. status-checks ✅
   Purpose: Service health status checks
```

#### Infrastructure Dashboards (5)
```
5. node-summary ✅
   Purpose: Kubernetes node overview

6. node-resources ✅
   Purpose: Node resource utilization

7. vm-metrics ✅
   Purpose: Virtual machine metrics

8. unattached-volumes ✅
   Purpose: Orphaned volume detection

9. ingress-overview ✅
   Purpose: Ingress traffic patterns
```

#### Log Dashboards (3)
```
10. onyx-all-logs ✅
    Purpose: Centralized log viewer for onyx services

11. quick-log-search ✅
    Purpose: Fast log search interface

12. loki ✅
    Purpose: Loki-specific metrics and logs
```

#### Database/Service Dashboards (4)
```
13. kafka-dashboard ✅
    Purpose: Kafka metrics (if deployed)

14. redis-dashboard ✅
    Purpose: Redis metrics (if deployed)

15. postgres-dashboard ✅
    Purpose: PostgreSQL (dagster-db) metrics

❌ mysql-dashboard
   Purpose: MySQL metrics
   Status: Disabled
```

#### Other Dashboards (1)
```
❌ windows-apps
   Purpose: Windows application monitoring
   Status: Disabled
```

### Log Collection (1 Active)
```
loki-s3
  Resource Type: log_collector
  Flavor: loki_aws_s3
  Version: 0.2
  Backend: S3 (loki-s3 bucket)
  Purpose: Log aggregation and storage
  Sources: All Kubernetes pods
  Retention: Long-term storage in S3
```

### Loki Alerting Rules (1 Active)
```
onyx-error-alerts
  Flavor: default
  Version: 0.1
  Purpose: Error detection and alerting
  Triggers: Error logs, exceptions, critical events
  Notification: SNS topic (onyx-notification)
```

### Kubernetes Monitoring (1 Active)
```
default
  Resource Type: kubernetes_monitoring
  Flavor: k8s
  Version: 0.1
  Purpose: Prometheus configuration for K8s monitoring
  Components:
    - Prometheus server
    - Node exporters
    - Kube-state-metrics
    - Service discovery
```

---

## 🛠️ DATA PLATFORM (DAGSTER)

### Helm Charts (6 Total, 3 Active)

```
1. dagster-daemon ✅
   Flavor: k8s
   Version: 0.1
   Purpose: Dagster daemon process
   Dependencies:
     - postgres/dagster-db
     - aws_efs/dagster-efs
     - config_map/dagster-job-config

2. dagster-webserver ✅
   Flavor: k8s
   Version: 0.1
   Purpose: Dagster web UI
   Ingress: ingress/dagster
   Auth: aws_cognito/dagster-access
   Dependencies:
     - postgres/dagster-db

3. k8s-dashboard-new ✅
   Flavor: helm_simple
   Purpose: Kubernetes dashboard

❌ victoria-metrics (k8s, v0.1, disabled)
❌ vict-metric-agent (k8s, v0.1, disabled)
❌ fluentbit (k8s, v0.1, disabled)
```

### Dagster Architecture
```
Components:
├─ Webserver (UI)
│  ├─ Ingress: ingress/dagster (AWS ALB)
│  ├─ Auth: AWS Cognito OIDC
│  └─ Database: postgres/dagster-db
│
├─ Daemon (Job Orchestrator)
│  ├─ Database: postgres/dagster-db
│  ├─ Storage: aws_efs/dagster-efs
│  └─ Job Execution: Kubernetes Jobs
│
└─ Data Pipeline
   ├─ Source: service/data-harvest
   ├─ Transform: Dagster jobs
   ├─ Load: S3/onelens-data
   └─ Query: onyx-dataware-house-api
```

---

## 🔧 ADDITIONAL RESOURCES

### AWS Lambda (1 Total, 0 Active)
```
❌ ol-sch-handler
   Flavor: default
   Version: 0.1
   Purpose: Scheduler handler function
   IAM Role: aws_iam_role/ol-sch-handler
   Status: Disabled
```

### AWS Amplify (1 Total, 0 Active)
```
❌ onelens-platform
   Flavor: default
   Version: 0.1
   Purpose: Frontend hosting (deprecated)
   Status: Disabled
```

### AWS Batch (1 Total, 0 Active)
```
❌ dh-ec2-test-sgp
   Flavor: default
   Version: 0.1
   Purpose: Batch job testing in Singapore region
   Status: Disabled
```

---

## 📈 RESOURCE SUMMARY BY TYPE

### Active Resources Count

| Resource Type | Active | Disabled | Total |
|--------------|--------|----------|-------|
| **Services** | 44 | 12 | 56 |
| **DynamoDB Tables** | 25 | 0 | 25 |
| **SQS Queues** | 7 | 1 | 8 |
| **SNS Topics** | 3 | 0 | 3 |
| **S3 Buckets** | 7 | 0 | 7 |
| **ConfigMaps** | 12 | 1 | 13 |
| **Grafana Dashboards** | 15 | 2 | 16 |
| **Ingress** | 4 | 3 | 7 |
| **IAM Roles** | 5 | 0 | 5 |
| **IAM Policies** | 3 | 0 | 3 |
| **Node Pools** | 1 | 13 | 14 |
| **Configurations** | 7 | 1 | 8 |
| **Helm Charts** | 3 | 3 | 6 |
| **Kubernetes Resources** | 1 | 4 | 5 |
| **PostgreSQL** | 1 | 0 | 1 |
| **OpenSearch** | 1 | 0 | 1 |
| **AWS Cognito** | 1 | 1 | 2 |
| **EFS** | 1 | 0 | 1 |
| **KMS** | 1 | 0 | 1 |
| **EventBridge** | 1 | 0 | 1 |
| **Log Collector** | 1 | 0 | 1 |
| **Loki Alerting Rules** | 1 | 0 | 1 |
| **K8s Monitoring** | 1 | 0 | 1 |
| **Network** | 1 | 0 | 1 |
| **Kubernetes Cluster** | 1 | 0 | 1 |
| **GCS Buckets** | 0 | 2 | 2 |
| **Lambda** | 0 | 1 | 1 |
| **Amplify** | 0 | 1 | 1 |
| **Batch Job** | 0 | 1 | 1 |
| **K8s Secrets** | 0 | 1 | 1 |
| **TOTAL** | **100** | **49** | **149** |

---

## 🔄 RESOURCE DEPENDENCIES MAP

### Service → Database Dependencies

```
onyx-authentication-api
  → postgres/dagster-db
  → dynamodb/onyx-auth-sso-tenant-mapping-db

onyx-workflow-* services
  → dynamodb/onyx-workflow-db
  → dynamodb/onyx-workflow-execution-db
  → dynamodb/onyx-workflow-trigger-db
  → dynamodb/onyx-workflow-settings-db
  → dynamodb/onyx-workflow-audit-db
  → dynamodb/onyx-workflow-version-db
  → dynamodb/onyx-workflow-global-trigger-db

onyx-runbooks-api
  → dynamodb/onyx-global-runbooks-db
  → dynamodb/onyx-tenant-runbooks-db
  → dynamodb/onyx-tenant-runbook-execution-db
  → dynamodb/onyx-tenant-runbook-audit-db
  → dynamodb/onyx-tenant-runbook-execution-counter-db
  → dynamodb/onyx-tenant-runbook-account-mapping-db
  → dynamodb/onyx-global-runbook-recommendation-db

onyx-integrations-api
  → dynamodb/onyx-global-integration-db
  → dynamodb/onyx-tenant-integration-db
  → dynamodb/onyx-tenant-integration-credentials-db
  → dynamodb/onyx-tenant-integration-audit-db
  → dynamodb/onyx-global-integration-action-config-db

onyx-request-processor-*
  → dynamodb/onyx-request-db
```

### Service → Queue Dependencies

```
onyx-workflow-execution-job
  → sqs/onyx-workflow-execution

onyx-workflow-trigger-job
  → sqs/onyx-workflow-trigger

onyx-workflow-cron-job
  → sqs/onyx-workflow-cron

onyx-request-processor-job
  → sqs/onyx-request-processor

onyx-log-processor-job
  → sqs/onyx-log-processor
```

### Service → ConfigMap Dependencies

```
onyx-authentication-api → config_map/onyx-authentication
onyx-workflow-mgmt-api → config_map/onyx-wf-mgmt
onyx-workflow-actions-api → config_map/onyx-wf-actions
onyx-workflow-execution-job → config_map/onyx-wf-execution
onyx-integrations-api → config_map/onyx-integrations
onyx-runbooks-api → config_map/runbooks-api-config
onyx-dashboard-api → config_map/onyx-dashboard
onyx-dataware-house-* → config_map/onyx-dwh
onyx-cost-center-* → config_map/onyx-cost-center
onyx-request-processor-job → config_map/onyx-request-proc
onyx-scheduler-api → config_map/onyx-scheduler
dagster-* → config_map/dagster-job-config
```

### Service → IAM Role Dependencies

```
All onyx-* services
  → aws_iam_role/onyx-role
    → iam_policy/onyx-permissions
    → AWS Managed Policy: CloudWatchLogsFullAccess

KEDA controller
  → aws_iam_role/keda-role

Step Functions
  → aws_iam_role/onyx-workflow-step-function-role
```

### Ingress → Service Routing

```
ingress/public-ingress (AWS ALB)
  → onyx-authentication-api
  → onyx-workflow-mgmt-api
  → onyx-integrations-api
  → onyx-runbooks-api
  → onyx-dashboard-api
  → onyx-cost-center-api
  → onyx-*-api (all public APIs)

ingress/dagster (AWS ALB)
  → helm/dagster-webserver

ingress/tools (NGINX)
  → Internal tools and dashboards

ingress/public-nlb-ingress (GCP ALB)
  → GCP environment services
```

### Event Flow Dependencies

```
EventBridge
  → aws_eventbridge/onyx-workflow-execution
    → sns/onyx-workflow-execution
      → sqs/onyx-workflow-execution
        → service/onyx-workflow-execution-job
          → dynamodb/onyx-workflow-execution-db
          → s3/onyx-workflow (artifacts)
```

---

## 🏗️ ARCHITECTURE PATTERNS IN USE

### 1. Event-Driven Architecture
```
EventBridge → SNS → SQS → Service Jobs
  - Decoupled services
  - Asynchronous processing
  - Scalable message handling
```

### 2. Microservices Pattern
```
56 independent services
  - Domain-driven design
  - Service per bounded context
  - Independent deployment
```

### 3. Multi-Tenancy
```
Logical isolation via DynamoDB partition keys
  - tenant-* tables
  - Shared infrastructure
  - Per-tenant data isolation
```

### 4. CQRS (Command Query Responsibility Segregation)
```
Write Path:
  onyx-*-api → DynamoDB

Read Path:
  onyx-dashboard-api
  onyx-dataware-house-api
```

### 5. Observability Stack
```
Metrics: Prometheus → Grafana
Logs: Services → Loki → S3 → Grafana/OpenSearch
Traces: (Not yet implemented)
```

---

## 🔒 SECURITY ARCHITECTURE

### Encryption
```
At Rest:
  - DynamoDB: KMS (onelens-key)
  - S3: Server-side encryption
  - EFS: Encrypted volumes
  - RDS: Encrypted snapshots

In Transit:
  - TLS via cert-manager
  - HTTPS ingress
  - Service mesh (future)
```

### Access Control
```
IRSA (IAM Roles for Service Accounts):
  - Pod-level IAM roles
  - Fine-grained permissions
  - No long-lived credentials

Cognito:
  - User authentication
  - Dagster UI access
```

### Network Security
```
VPC:
  - Public subnets (ingress)
  - Private subnets (services, databases)
  - NAT gateways
  - Security groups
```

---

## 📝 NAMING CONVENTIONS

### Resource Naming Pattern
```
{domain}-{component}-{type}

Examples:
  - onyx-workflow-mgmt-api
  - onyx-tenant-runbooks-db
  - dagster-daemon
  - public-ingress
```

### DynamoDB Naming Pattern
```
{domain}-{scope}-{entity}-db

Examples:
  - onyx-global-runbooks-db (global scope)
  - onyx-tenant-integration-db (tenant scope)
  - onyx-workflow-db (no scope = core)
```

### Service Naming Pattern
```
{domain}-{function}-{type}

Examples:
  - onyx-workflow-execution-job (job)
  - onyx-authentication-api (api)
  - data-harvest (service)
```

---

## 🚀 DEPLOYMENT INFORMATION

### GitOps Configuration
```
Repository: https://github.com/astuto-ai/onelens.git
Branch: master
GitOps: Enabled (all environments)
CI/CD: Facets-managed deployments
```

### Release History (Recent)
```
prod (AWS):
  Last Deploy: 2025-12-16 09:00
  Status: SUCCESS

prod-gcp (GCP):
  Last Deploy: 2025-12-16 12:32
  Status: IN_PROGRESS

test-gcp (GCP):
  Last Deploy: 2025-12-16 12:27
  Status: SUCCESS
```

---

## 📊 CAPACITY & SCALING

### Current Scaling Configuration
```
Most services:
  min: 1
  max: 1

Status: Fixed scaling (no autoscaling enabled yet)
```

### Autoscaling Infrastructure (Available)
```
HPA: Configured but not actively used
VPA: configuration/vpa available
KEDA: configuration/keda available for event-driven scaling
Cluster Autoscaler: configuration/cluster-autoscalar active
```

---

## 💡 KEY INSIGHTS

### Strengths
- ✅ Comprehensive observability (Prometheus, Loki, Grafana, OpenSearch)
- ✅ Event-driven architecture (EventBridge, SNS, SQS)
- ✅ Multi-cloud capability (AWS + GCP)
- ✅ Domain-driven design (25 DynamoDB tables)
- ✅ GitOps-enabled deployments

### Opportunities
- 🎯 Enable autoscaling (HPA, KEDA)
- 🎯 Activate GCP node pools for multi-cloud load distribution
- 🎯 Consolidate disabled resources
- 🎯 Implement distributed tracing
- 🎯 Add health checks to all services

---

**Document Generated:** 2025-12-16
**For Project:** onelens-4786099461
**Total Resources:** 149 (100 active, 49 disabled)
**Environments:** 6 (3 running successfully, 1 in progress, 2 failed)
