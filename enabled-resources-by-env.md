# OneLens Enabled Resources - Running Environments

**Project:** onelens-4786099461
**Active Environments:**
- **prod** (AWS) - Production
- **test** (AWS) - QA/Testing
- **prod-gcp** (GCP) - Production
- **test-gcp** (GCP) - Development/Testing

---

## Summary: 125 Enabled Resources

### AWS COGNITO (1)

- **dagster-access**
  - Flavor: `astuto-default`
  - Version: `0.1`

### AWS EFS (1)

- **dagster-efs**
  - Flavor: `default`
  - Version: `0.1`

### AWS EVENTBRIDGE (1)

- **onyx-workflow-execution**
  - Flavor: `default`
  - Version: `0.1`

### AWS IAM ROLE (5)

- **full-services-access**
  - Flavor: `default`
  - Version: `0.1`
- **keda-role**
  - Flavor: `default`
  - Version: `0.1`
- **ol-sch-handler**
  - Flavor: `default`
  - Version: `0.1`
- **onyx-role**
  - Flavor: `default`
  - Version: `0.1`
- **onyx-workflow-step-function-role**
  - Flavor: `default`
  - Version: `0.1`

### CONFIG MAP (12)

- **dagster-job-config**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-authentication**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-cost-center**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-dashboard**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-dwh**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-integrations**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-request-proc**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-scheduler**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-wf-actions**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-wf-execution**
  - Flavor: `k8s`
  - Version: `0.3`
- **onyx-wf-mgmt**
  - Flavor: `k8s`
  - Version: `0.3`
- **runbooks-api-config**
  - Flavor: `k8s`
  - Version: `0.3`

### CONFIGURATION (7)

- **alb**
- **cert-manager**
- **cluster-autoscalar**
  - Flavor: `default`
  - Version: `0.1`
- **eks_addon**
  - Flavor: `default`
  - Version: `0.2`
- **keda**
  - Version: `0.1`
- **prometheus**
  - Version: `latest`
- **vpa**
  - Version: `0.1`

### DYNAMODB (23)

- **onyx-auth-sso-tenant-mapping-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-global-integration-action-config-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-global-integration-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-global-runbook-recommendation-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-global-runbooks-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-notification-rate-limit-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-request-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-integration-audit-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-integration-credentials-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-integration-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-runbook-account-mapping-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-runbook-audit-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-runbook-execution-counter-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-runbook-execution-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-tenant-runbooks-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-workflow-audit-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-workflow-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-workflow-execution-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-workflow-global-trigger-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-workflow-settings-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-workflow-trigger-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`
- **onyx-workflow-version-db**
  - Flavor: `astuto-dynamodb`
  - Version: `0.1`

### ELASTICSEARCH (1)

- **logs**
  - Flavor: `opensearch`
  - Version: `0.2`

### GRAFANA DASHBOARD (15)

- **app-usage-summary**
  - Flavor: `default`
  - Version: `latest`
- **application-dashboard**
  - Flavor: `default`
  - Version: `latest`
- **application-resource-summary**
  - Flavor: `default`
  - Version: `latest`
- **ingress-overview**
  - Flavor: `default`
  - Version: `latest`
- **kafka-dashboard**
  - Flavor: `default`
  - Version: `latest`
- **loki**
  - Flavor: `default`
  - Version: `latest`
- **node-resources**
  - Flavor: `default`
  - Version: `latest`
- **node-summary**
  - Flavor: `default`
  - Version: `latest`
- **onyx-all-logs**
  - Flavor: `default`
  - Version: `latest`
- **postgres-dashboard**
  - Flavor: `default`
  - Version: `latest`
- **quick-log-search**
  - Flavor: `default`
  - Version: `latest`
- **redis-dashboard**
  - Flavor: `default`
  - Version: `latest`
- **status-checks**
  - Flavor: `default`
  - Version: `latest`
- **unattached-volumes**
  - Flavor: `default`
  - Version: `latest`
- **vm-metrics**
  - Flavor: `default`
  - Version: `latest`

### HELM (3)

- **dagster-daemon**
  - Flavor: `k8s`
  - Version: `0.1`
- **dagster-webserver**
  - Flavor: `k8s`
  - Version: `0.1`
- **k8s-dashboard-new**
  - Flavor: `helm_simple`

### IAM POLICY (3)

- **full-services-access**
  - Flavor: `aws_iam_policy`
  - Version: `0.2`
- **ol-sch-handler**
  - Flavor: `aws_iam_policy`
  - Version: `0.2`
- **onyx-permissions**
  - Flavor: `aws_iam_policy`
  - Version: `0.2`

### INGRESS (4)

- **dagster**
  - Flavor: `aws_alb`
  - Version: `0.2`
- **public-ingress**
  - Flavor: `aws_alb`
  - Version: `0.2`
- **public-nlb-ingress**
  - Flavor: `gcp_alb`
  - Version: `0.2`
- **tools**
  - Flavor: `nginx_k8s_native`
  - Version: `0.1`

### K8S RESOURCE (1)

- **public-nlb-backend-config**
  - Flavor: `default`
  - Version: `latest`

### KMS (1)

- **onelens-key**
  - Flavor: `default`
  - Version: `0.1`

### KUBERNETES CLUSTER (1)

- **default**
  - Flavor: `default`
  - Version: `0.1`

### KUBERNETES MONITORING (1)

- **default**
  - Flavor: `k8s`
  - Version: `0.1`

### KUBERNETES NODE POOL (1)

- **jobs-node**
  - Flavor: `eks_self_managed`
  - Version: `0.1`

### LOG COLLECTOR (1)

- **loki-s3**
  - Flavor: `loki_aws_s3`
  - Version: `0.2`

### LOKI ALERTING RULES (1)

- **onyx-error-alerts**
  - Flavor: `default`
  - Version: `0.1`

### NETWORK (1)

- **default**
  - Flavor: `default`
  - Version: `0.1`

### POSTGRES (1)

- **dagster-db**
  - Flavor: `rds`
  - Version: `0.1`

### S3 (7)

- **kubernetes-s3-bucket**
  - Flavor: `default`
  - Version: `0.2`
- **loki-s3**
  - Flavor: `default`
  - Version: `0.2`
- **onelens-data**
  - Flavor: `default`
  - Version: `0.2`
- **onelens-downloads**
  - Flavor: `default`
  - Version: `0.2`
- **onelens-tenants-cur**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-backend**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-workflow**
  - Flavor: `default`
  - Version: `0.2`

### SERVICE (22)

- **data-harvest**
  - Flavor: `deployment`
  - Version: `0.1`
- **onelens-backend**
  - Flavor: `k8s`
  - Version: `0.1`
- **onyx-ai-insights-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-authentication-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-cost-center-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-cost-center-job**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-dashboard-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-dataware-house-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-dataware-house-api-temp**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-dataware-house-job**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-integrations-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-log-processor-job**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-request-processor-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-request-processor-job**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-runbooks-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-scheduler-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-workflow-actions-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-workflow-cron-job**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-workflow-execution-job**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-workflow-mgmt-api**
  - Flavor: `deployment`
  - Version: `0.1`
- **onyx-workflow-trigger-job**
  - Flavor: `deployment`
  - Version: `0.1`
- **policy-master-tool**
  - Flavor: `deployment`
  - Version: `0.1`

### SNS (3)

- **onyx-notification**
  - Flavor: `default`
  - Version: `0.1`
- **onyx-workflow-execution**
  - Flavor: `default`
  - Version: `0.1`
- **onyx-workflow-trigger**
  - Flavor: `default`
  - Version: `0.1`

### SQS (8)

- **olschedulerdlq**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-log-processor**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-orchestrator**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-request-processor**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-workflow-cron**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-workflow-dlq**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-workflow-execution**
  - Flavor: `default`
  - Version: `0.2`
- **onyx-workflow-trigger**
  - Flavor: `default`
  - Version: `0.2`
