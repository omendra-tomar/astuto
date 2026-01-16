# Facets Multi-Application Tagging Guide

This guide helps you implement application-level tagging for cost segregation in your Facets project.

## 📋 Overview

Your `onelens-4786099461` project contains resources for multiple applications:
- **Onyx** (86 resources) - Core backend services and infrastructure
- **Onelens** (7 resources) - Application-specific services
- **Shared** (~20 resources) - Platform infrastructure used by both

## 🎯 Tagging Strategy

Each resource will get tags in the blueprint `spec` section:

```json
{
  "spec": {
    "app_name": "onyx",          // or "onelens" or "shared"
    "cost_center": "onyx-team",  // or "onelens-team" or "platform-team"
    // ... rest of existing fields
  }
}
```

These tags automatically propagate to:
- **AWS**: Tags (`Application=onyx`)
- **GCP**: Labels (`application=onyx`)
- **Azure**: Tags (`Application=onyx`)

## 📊 Resource Breakdown

### ONYX Resources (app_name: "onyx", 86 total)

| Resource Type | Count | Examples |
|--------------|-------|----------|
| Services | 28 | onyx-workflow-mgmt-api, onyx-integrations-api, onyx-dashboard-api |
| DynamoDB Tables | 25 | onyx-request-db, onyx-workflow-db, onyx-tenant-db |
| SQS Queues | 7 | onyx-orchestrator, onyx-log-processor, onyx-workflow-dlq |
| SNS Topics | 3 | onyx-workflow-execution, onyx-notification, onyx-workflow-trigger |
| S3 Buckets | 2 | onyx-backend, onyx-workflow |
| ConfigMaps | 11 | onyx-request-proc, onyx-integrations, onyx-dwh |
| IAM | 2 | onyx-permissions (policy), onyx-role (role) |
| EventBridge | 1 | onyx-workflow-execution |

### ONELENS Resources (app_name: "onelens", 7 total)

| Resource Type | Count | Examples |
|--------------|-------|----------|
| Services | 2 | onelens-backend, onelens-platform |
| S3 Buckets | 4 | onelens-downloads, onelens-tenants-cur, onelens-data |
| KMS | 1 | onelens-key |

### SHARED Resources (app_name: "shared", ~20 total)

| Resource Type | Count | Examples |
|--------------|-------|----------|
| S3 Buckets | 2 | loki-s3, kubernetes-s3-bucket |
| EFS | 1 | dagster-efs |
| Postgres | 1 | dagster-db |
| Services | 2 | policy-master-tool, data-harvest |
| ConfigMaps | 1 | dagster-job-config |
| IAM Policies | 2 | full-services-access, ol-sch-handler |
| IAM Roles | 3 | keda-role, full-services-access, ol-sch-handler |
| Kubernetes | 1 | default (cluster) |
| Monitoring | 1 | default |
| OpenSearch | 1 | logs |
| Network | 1 | default |

## 🚀 Quick Start

### Prerequisites

1. **Raptor CLI** installed and authenticated
2. **jq** installed (JSON processor)
   ```bash
   # Mac
   brew install jq

   # Ubuntu/Debian
   sudo apt-get install jq

   # CentOS/RHEL
   sudo yum install jq
   ```

### Step 1: Run the Tagging Script

```bash
# Make the script executable
chmod +x add-app-tags.sh

# Run the script (takes ~15-20 minutes for 93 resources)
./add-app-tags.sh
```

**Expected Output:**
```
╔════════════════════════════════════════════════════════════════╗
║         Facets Resource Tagging Script                        ║
║         Project: onelens-4786099461                           ║
╚════════════════════════════════════════════════════════════════╝

Checking prerequisites...
✓ Prerequisites satisfied

┌────────────────────────────────────────────────────────────────┐
│                    ONYX RESOURCES                              │
└────────────────────────────────────────────────────────────────┘

═══════════════════════════════════════════════════════════════
Batch: service (app_name: onyx)
═══════════════════════════════════════════════════════════════
Processing: service/onyx-workflow-mgmt-api
  ✓ Updated: app_name=onyx, cost_center=onyx-team
Processing: service/onyx-workflow-actions-api
  ✓ Updated: app_name=onyx, cost_center=onyx-team
...
```

### Step 2: Verify the Tags

```bash
# Make verification script executable
chmod +x verify-app-tags.sh

# Run verification
./verify-app-tags.sh
```

**Expected Output:**
```
════════════════════════════════════════════════════════════════
                   TAGGING SUMMARY
════════════════════════════════════════════════════════════════

✓ ONYX Resources (app_name: onyx):        86
✓ ONELENS Resources (app_name: onelens):  7
✓ SHARED Resources (app_name: shared):    20
✗ Untagged Resources (no app_name):       0

Total Resources: 113

╔════════════════════════════════════════════════════════════════╗
║          ALL RESOURCES ARE PROPERLY TAGGED! ✓                  ║
╚════════════════════════════════════════════════════════════════╝
```

### Step 3: Deploy the Changes

```bash
# List available environments
raptor get environments --project onelens-4786099461

# Deploy to production (tags propagate automatically)
raptor create release \
  --project onelens-4786099461 \
  --environment production \
  -w

# Deploy to staging
raptor create release \
  --project onelens-4786099461 \
  --environment staging \
  -w
```

### Step 4: Verify Cloud Tags

#### AWS Console Verification

```bash
# List all resources with Application=onyx tag
aws resourcegroupstaggingapi get-resources \
  --tag-filters Key=Application,Values=onyx \
  --output table

# Check specific DynamoDB table
aws dynamodb describe-table \
  --table-name onyx-request-db \
  --query 'Table.Tags' \
  --output table

# Expected output:
# ┌─────────────┬────────────┐
# │     Key     │   Value    │
# ├─────────────┼────────────┤
# │ Application │ onyx       │
# │ CostCenter  │ onyx-team  │
# └─────────────┴────────────┘

# Check S3 bucket tags
aws s3api get-bucket-tagging \
  --bucket onyx-backend \
  --output table
```

#### GCP Console Verification (if applicable)

```bash
# List all resources with application=onelens label
gcloud asset search-all-resources \
  --query="labels.application=onelens" \
  --format="table(name,labels)"
```

### Step 5: Cost Analysis

#### AWS Cost Explorer

1. Go to AWS Console → Cost Explorer
2. Click **"Create Report"**
3. Add filter: **Tag → Application = onyx**
4. View costs for all Onyx resources
5. Repeat with **Application = onelens** and **Application = shared**

#### AWS Cost Allocation Tags

1. Go to AWS Console → Billing → Cost Allocation Tags
2. Activate the following tags:
   - `Application`
   - `CostCenter`
3. Wait 24 hours for tags to appear in Cost Explorer

#### Example Cost Report Query

```bash
# Get cost breakdown by Application tag (last 30 days)
aws ce get-cost-and-usage \
  --time-period Start=2024-12-16,End=2025-01-16 \
  --granularity MONTHLY \
  --metrics "UnblendedCost" \
  --group-by Type=TAG,Key=Application \
  --output table
```

## 🔧 Manual Updates

If you need to update a single resource manually:

```bash
# 1. Get current resource configuration
raptor get resources \
  --project onelens-4786099461 \
  service/onyx-workflow-mgmt-api \
  -o json > resource.json

# 2. Edit resource.json and add to spec section:
#    "app_name": "onyx",
#    "cost_center": "onyx-team",

# 3. Apply updated configuration
raptor apply -f resource.json --project onelens-4786099461

# 4. Verify
raptor get resources \
  --project onelens-4786099461 \
  service/onyx-workflow-mgmt-api \
  -o json | grep app_name
```

## 📁 Generated Files

After running the scripts, you'll have:

- `/tmp/facets-resource-tags.csv` - Complete resource inventory with tags
- `/tmp/all-resources.json` - Full resource JSON dump

## 🎨 Tag Format Summary

| Application | app_name | cost_center | Resources |
|------------|----------|-------------|-----------|
| **Onyx** | `"onyx"` | `"onyx-team"` | 86 resources |
| **Onelens** | `"onelens"` | `"onelens-team"` | 7 resources |
| **Shared** | `"shared"` | `"platform-team"` | ~20 resources |

## 🔍 Troubleshooting

### Issue: Script fails with "raptor: command not found"

**Solution:** Install and authenticate Raptor CLI:
```bash
# Check installation
raptor --version

# Authenticate
raptor auth login
```

### Issue: Script fails with "jq: command not found"

**Solution:** Install jq:
```bash
# Mac
brew install jq

# Ubuntu
sudo apt-get install jq
```

### Issue: Some resources fail to update

**Solution:** Run the script again (it skips already-tagged resources):
```bash
./add-app-tags.sh
```

### Issue: Tags don't appear in AWS Console

**Solution:**
1. Wait for deployment to complete
2. Verify Terraform modules propagate tags (check module code)
3. Activate cost allocation tags in AWS Billing console

## 📞 Next Steps

After successful tagging:

1. ✅ Activate cost allocation tags in AWS Billing
2. ✅ Set up Cost Explorer reports for each application
3. ✅ Create billing alerts per application
4. ✅ Document tagging standards for new resources
5. ✅ Add `app_name` validation to CI/CD pipeline

## 📚 Additional Resources

- [Facets Documentation](https://docs.facets.cloud)
- [AWS Cost Allocation Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html)
- [GCP Labels Best Practices](https://cloud.google.com/resource-manager/docs/creating-managing-labels)

---

**Questions?** Contact your Facets support team or platform engineering team.