# Blueprint Resources - Complete List with Names

## 1. Cloud-Agnostic Resources (7 Types – 54 Resources)

### service (22 services)
```
service/onyx-workflow-mgmt-api
service/onyx-workflow-actions-api
service/onyx-workflow-cron-job
service/onyx-workflow-execution-job
service/onyx-workflow-trigger-job
service/onyx-integrations-api
service/onyx-request-processor-api
service/onyx-request-processor-job
service/onyx-dashboard-api
service/onyx-dataware-house-api
service/onyx-dataware-house-api-temp
service/onyx-dataware-house-job
service/onyx-ai-insights-api
service/onyx-runbooks-api
service/onyx-authentication-api
service/onyx-cost-center-api
service/onyx-cost-center-job
service/onyx-scheduler-api
service/onyx-log-processor-job
service/onelens-backend
service/policy-master-tool
service/data-harvest
```

### config_map (12 configmaps)
```
config_map/onyx-request-proc
config_map/onyx-integrations
config_map/onyx-dwh
config_map/onyx-dashboard
config_map/onyx-authentication
config_map/onyx-wf-execution
config_map/onyx-wf-mgmt
config_map/onyx-wf-actions
config_map/onyx-scheduler
config_map/onyx-cost-center
config_map/runbooks-api-config
config_map/dagster-job-config
```

### helm (3 releases)
```
helm/k8s-dashboard-new
helm/dagster-daemon
helm/dagster-webserver
```

### grafana_dashboard (15 dashboards)
```
grafana_dashboard/node-summary
grafana_dashboard/node-resources
grafana_dashboard/loki
grafana_dashboard/kafka-dashboard
grafana_dashboard/ingress-overview
grafana_dashboard/application-dashboard
grafana_dashboard/application-resource-summary
grafana_dashboard/app-usage-summary
grafana_dashboard/postgres-dashboard
grafana_dashboard/redis-dashboard
grafana_dashboard/status-checks
grafana_dashboard/quick-log-search
grafana_dashboard/onyx-all-logs
grafana_dashboard/unattached-volumes
grafana_dashboard/vm-metrics
```

### kubernetes_monitoring (1)
```
kubernetes_monitoring/default
```

### log_collector (1)
```
log_collector/loki-s3
```

### kubernetes_node_pool (1 enabled)
```
kubernetes_node_pool/jobs-node
```

---

## 2. Flavor-Change Resources (3 Types – 5 Resources)

### postgres (1 database)
```
postgres/dagster-db
  - AWS: flavor = rds
  - GCP: flavor = alloydb
```

### ingress (4 controllers)
```
ingress/tools
ingress/public-nlb-ingress
ingress/dagster
ingress/public-ingress
  - AWS: flavor = aws_alb
  - GCP: flavor = gcp_alb
```

### kubernetes_node_pool (same as section 1)
```
kubernetes_node_pool/jobs-node
  - AWS: flavor = eks_managed
  - GCP: flavor = gke_node_pool
```

---

## 3. AWS-Only Resources (7 Types – 49 Resources)

### s3 (7 buckets)
```
s3/onyx-backend
s3/onyx-workflow
s3/onelens-downloads
s3/onelens-tenants-cur
s3/onelens-data
s3/loki-s3
s3/kubernetes-s3-bucket
```

### dynamodb (23 tables)
```
dynamodb/onyx-request-db
dynamodb/onyx-workflow-db
dynamodb/onyx-tenant-db
dynamodb/onyx-global-runbooks-db
dynamodb/onyx-workflow-execution-db
dynamodb/onyx-workflow-trigger-db
dynamodb/onyx-workflow-settings-db
dynamodb/onyx-global-integration-db
dynamodb/onyx-global-integration-action-config-db
dynamodb/onyx-tenant-integration-db
dynamodb/onyx-tenant-integration-credentials-db
dynamodb/onyx-tenant-integration-audit-db
dynamodb/onyx-tenant-runbooks-db
dynamodb/onyx-auth-sso-tenant-mapping-db
dynamodb/onyx-workflow-audit-db
dynamodb/onyx-tenant-runbook-execution-db
dynamodb/onyx-tenant-runbook-audit-db
dynamodb/onyx-tenant-runbook-execution-counter-db
dynamodb/onyx-tenant-runbook-account-mapping-db
dynamodb/onyx-global-runbook-recommendation-db
dynamodb/onyx-notification-rate-limit-db
dynamodb/onyx-workflow-global-trigger-db
dynamodb/onyx-workflow-version-db
```

### sqs (8 queues)
```
sqs/onyx-orchestrator
sqs/onyx-log-processor
sqs/onyx-workflow-dlq
sqs/onyx-workflow-cron
sqs/onyx-request-processor
sqs/onyx-workflow-execution
sqs/onyx-workflow-trigger
sqs/olschedulerdlq
```

### sns (3 topics)
```
sns/onyx-workflow-execution
sns/onyx-notification
sns/onyx-workflow-trigger
```

### kms (1 key)
```
kms/onelens-key
```

### aws_iam_role (5 roles)
```
aws_iam_role/keda-role
aws_iam_role/onyx-role
aws_iam_role/full-services-access
aws_iam_role/ol-sch-handler
aws_iam_role/onyx-workflow-step-function-role
```

### iam_policy (3 policies)
```
iam_policy/full-services-access
iam_policy/onyx-permissions
iam_policy/ol-sch-handler
```

---

## 4. Confirmed Removals (4 Resources – Remove from Blueprint)

```
❌ aws_cognito/dagster-access – No longer required
❌ aws_cognito/dagster – No longer required
❌ aws_efs/dagster-efs – Replaced by GCP alternative
❌ elasticsearch/logs – Replaced by Loki
```

---

## 5. Needs Confirmation (Do Not Remove Yet)

```
⚠️ aws_eventbridge/onyx-workflow-execution – Confirm with Clement
```

---

## Summary

| Category | Types | Resources |
|----------|-------|-----------|
| Cloud-Agnostic | 7 | 54 |
| Flavor-Change | 3 | 5 |
| AWS-Only | 7 | 49 |
| **TOTAL (Keep)** | **17** | **108** |
| Remove | 4 | 4 |
| Confirm | 1 | 1 |
