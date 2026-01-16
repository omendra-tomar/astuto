#!/bin/bash
#############################################################################
# Script: add-app-tags.sh
# Purpose: Add app_name and cost_center tags to Facets resources
# Project: onelens-4786099461
#
# This script categorizes resources into three groups:
#   - app_name: "onyx" (Onyx application resources)
#   - app_name: "onelens" (Onelens application resources)
#   - app_name: "shared" (Shared infrastructure resources)
#############################################################################

set -e  # Exit on error

PROJECT="onelens-4786099461"
TEMP_DIR="/tmp/facets-tagging-$$"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create temp directory
mkdir -p "$TEMP_DIR"

# Counters
TOTAL_UPDATED=0
TOTAL_FAILED=0
TOTAL_SKIPPED=0

#############################################################################
# Function: add_app_name
# Description: Adds app_name and cost_center to a resource's spec
# Parameters:
#   $1 - resource_type (e.g., "service", "dynamodb", "sqs")
#   $2 - resource_name (e.g., "onyx-workflow-mgmt-api")
#   $3 - app_name (e.g., "onyx", "onelens", "shared")
#   $4 - cost_center (e.g., "onyx-team", "onelens-team", "platform-team")
#############################################################################
add_app_name() {
  local resource_type=$1
  local resource_name=$2
  local app_name=$3
  local cost_center=$4

  local resource_id="${resource_type}/${resource_name}"

  echo -e "${BLUE}Processing: ${resource_id}${NC}"

  # Get current resource configuration
  if ! raptor get resources --project "$PROJECT" "$resource_id" -o json > "$TEMP_DIR/resource.json" 2>/dev/null; then
    echo -e "${RED}  ✗ Failed to get resource: ${resource_id}${NC}"
    ((TOTAL_FAILED++))
    return 1
  fi

  # Check if resource already has app_name
  if grep -q '"app_name"' "$TEMP_DIR/resource.json"; then
    local current_app=$(jq -r '.spec.app_name // empty' "$TEMP_DIR/resource.json")
    if [ "$current_app" = "$app_name" ]; then
      echo -e "${YELLOW}  ⊙ Skipped: Already has app_name=$app_name${NC}"
      ((TOTAL_SKIPPED++))
      return 0
    fi
  fi

  # Add app_name and cost_center to spec using jq
  if ! jq --arg app "$app_name" --arg cc "$cost_center" \
    '.spec.app_name = $app | .spec.cost_center = $cc' \
    "$TEMP_DIR/resource.json" > "$TEMP_DIR/resource-updated.json"; then
    echo -e "${RED}  ✗ Failed to update JSON: ${resource_id}${NC}"
    ((TOTAL_FAILED++))
    return 1
  fi

  # Apply updated configuration
  if ! raptor apply -f "$TEMP_DIR/resource-updated.json" --project "$PROJECT" > "$TEMP_DIR/apply-output.log" 2>&1; then
    echo -e "${RED}  ✗ Failed to apply: ${resource_id}${NC}"
    cat "$TEMP_DIR/apply-output.log"
    ((TOTAL_FAILED++))
    return 1
  fi

  echo -e "${GREEN}  ✓ Updated: app_name=${app_name}, cost_center=${cost_center}${NC}"
  ((TOTAL_UPDATED++))
  return 0
}

#############################################################################
# Function: batch_update
# Description: Updates multiple resources of the same type with same tags
# Parameters:
#   $1 - resource_type
#   $2 - app_name
#   $3 - cost_center
#   $4+ - resource_names (space-separated)
#############################################################################
batch_update() {
  local resource_type=$1
  local app_name=$2
  local cost_center=$3
  shift 3
  local resource_names=("$@")

  echo ""
  echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"
  echo -e "${YELLOW}Batch: ${resource_type} (app_name: ${app_name})${NC}"
  echo -e "${YELLOW}═══════════════════════════════════════════════════════════${NC}"

  for resource_name in "${resource_names[@]}"; do
    add_app_name "$resource_type" "$resource_name" "$app_name" "$cost_center"
    sleep 0.5  # Rate limiting
  done
}

#############################################################################
# MAIN SCRIPT EXECUTION
#############################################################################

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         Facets Resource Tagging Script                        ║"
echo "║         Project: onelens-4786099461                           ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check prerequisites
echo "Checking prerequisites..."
if ! command -v raptor &> /dev/null; then
    echo -e "${RED}ERROR: raptor CLI not found. Please install it first.${NC}"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo -e "${RED}ERROR: jq not found. Please install it first.${NC}"
    echo "  Mac: brew install jq"
    echo "  Ubuntu: sudo apt-get install jq"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites satisfied${NC}"
echo ""

#############################################################################
# ONYX RESOURCES (app_name: "onyx", cost_center: "onyx-team")
#############################################################################

echo -e "${GREEN}"
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│                    ONYX RESOURCES                              │"
echo "└────────────────────────────────────────────────────────────────┘"
echo -e "${NC}"

# Onyx Services (28 services)
batch_update "service" "onyx" "onyx-team" \
  onyx-workflow-mgmt-api \
  onyx-workflow-actions-api \
  onyx-workflow-cron-job \
  onyx-workflow-execution-job \
  onyx-workflow-trigger-job \
  onyx-integrations-api \
  onyx-global-integration-db \
  onyx-global-integration-action-config-db \
  onyx-tenant-integration-db \
  onyx-tenant-integration-credentials-db \
  onyx-tenant-integration-audit-db \
  onyx-request-processor-api \
  onyx-request-processor-job \
  onyx-dashboard-api \
  onyx-dataware-house-api \
  onyx-dataware-house-job \
  onyx-ai-insights-api \
  onyx-runbooks-api \
  onyx-authentication-api \
  onyx-cost-center-api \
  onyx-cost-center-job \
  onyx-scheduler-api \
  onyx-log-processor-job

# Onyx DynamoDB Tables (25 tables)
batch_update "dynamodb" "onyx" "onyx-team" \
  onyx-request-db \
  onyx-workflow-db \
  onyx-tenant-db \
  onyx-global-runbooks-db \
  onyx-workflow-action-db \
  onyx-workflow-condition-db \
  onyx-workflow-trigger-db \
  onyx-workflow-execution-db \
  onyx-workflow-step-db \
  onyx-workflow-scheduler-db \
  onyx-workflow-cron-db \
  onyx-global-integration-db \
  onyx-global-integration-action-config-db \
  onyx-tenant-integration-db \
  onyx-tenant-integration-credentials-db \
  onyx-tenant-integration-audit-db \
  onyx-request-processor-db \
  onyx-dashboard-db \
  onyx-dataware-house-db \
  onyx-ai-insights-db \
  onyx-tenant-runbooks-db \
  onyx-authentication-db \
  onyx-cost-center-db \
  onyx-notification-db \
  onyx-scheduler-db

# Onyx SQS Queues (7 queues)
batch_update "sqs" "onyx" "onyx-team" \
  onyx-orchestrator \
  onyx-log-processor \
  onyx-workflow-dlq \
  onyx-workflow-cron \
  onyx-request-processor \
  onyx-workflow-execution \
  onyx-workflow-trigger

# Onyx SNS Topics (3 topics)
batch_update "sns" "onyx" "onyx-team" \
  onyx-workflow-execution \
  onyx-notification \
  onyx-workflow-trigger

# Onyx S3 Buckets (2 buckets)
batch_update "s3" "onyx" "onyx-team" \
  onyx-backend \
  onyx-workflow

# Onyx ConfigMaps (11 configmaps)
batch_update "configmap" "onyx" "onyx-team" \
  onyx-request-proc \
  onyx-integrations \
  onyx-dwh \
  onyx-dashboard \
  onyx-authentication \
  onyx-wf-execution \
  onyx-wf-mgmt \
  onyx-wf-actions \
  onyx-scheduler \
  onyx-cost-center \
  runbooks-api-config

# Onyx IAM Resources
batch_update "iam_policy" "onyx" "onyx-team" \
  onyx-permissions

batch_update "iam_role" "onyx" "onyx-team" \
  onyx-role

# Onyx EventBridge
batch_update "eventbridge" "onyx" "onyx-team" \
  onyx-workflow-execution

#############################################################################
# ONELENS RESOURCES (app_name: "onelens", cost_center: "onelens-team")
#############################################################################

echo ""
echo -e "${GREEN}"
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│                  ONELENS RESOURCES                             │"
echo "└────────────────────────────────────────────────────────────────┘"
echo -e "${NC}"

# Onelens Services (2 services)
batch_update "service" "onelens" "onelens-team" \
  onelens-backend \
  onelens-platform

# Onelens S3 Buckets (4 buckets)
batch_update "s3" "onelens" "onelens-team" \
  onelens-downloads \
  onelens-tenants-cur \
  onelens-data

# Onelens KMS
batch_update "kms" "onelens" "onelens-team" \
  onelens-key

#############################################################################
# SHARED RESOURCES (app_name: "shared", cost_center: "platform-team")
#############################################################################

echo ""
echo -e "${GREEN}"
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│                   SHARED RESOURCES                             │"
echo "└────────────────────────────────────────────────────────────────┘"
echo -e "${NC}"

# Shared S3 Buckets
batch_update "s3" "shared" "platform-team" \
  loki-s3 \
  kubernetes-s3-bucket

# Shared EFS
batch_update "efs" "shared" "platform-team" \
  dagster-efs

# Shared Database
batch_update "postgres" "shared" "platform-team" \
  dagster-db

# Shared Services
batch_update "service" "shared" "platform-team" \
  policy-master-tool \
  data-harvest

# Shared ConfigMaps
batch_update "configmap" "shared" "platform-team" \
  dagster-job-config

# Shared IAM
batch_update "iam_policy" "shared" "platform-team" \
  full-services-access \
  ol-sch-handler

batch_update "iam_role" "shared" "platform-team" \
  keda-role \
  full-services-access \
  ol-sch-handler

# Shared Kubernetes Cluster
batch_update "kubernetes_cluster" "shared" "platform-team" \
  default

# Shared Monitoring
batch_update "monitoring" "shared" "platform-team" \
  default

# Shared OpenSearch
batch_update "opensearch" "shared" "platform-team" \
  logs

# Shared Network
batch_update "network" "shared" "platform-team" \
  default

#############################################################################
# SUMMARY
#############################################################################

echo ""
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                      EXECUTION SUMMARY                         ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${GREEN}✓ Successfully Updated: ${TOTAL_UPDATED}${NC}"
echo -e "${YELLOW}⊙ Skipped (Already Tagged): ${TOTAL_SKIPPED}${NC}"
echo -e "${RED}✗ Failed: ${TOTAL_FAILED}${NC}"
echo ""
echo -e "${BLUE}Total Processed: $((TOTAL_UPDATED + TOTAL_SKIPPED + TOTAL_FAILED))${NC}"
echo ""

if [ $TOTAL_FAILED -eq 0 ]; then
  echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║              ALL RESOURCES TAGGED SUCCESSFULLY! ✓              ║${NC}"
  echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo "Next Steps:"
  echo "1. Verify tags: raptor get resources --project $PROJECT -o json | grep app_name"
  echo "2. Deploy changes: raptor create release --project $PROJECT --environment <ENV> -w"
  echo "3. Verify cloud tags in AWS/GCP console"
else
  echo -e "${RED}╔════════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${RED}║           SOME RESOURCES FAILED TO UPDATE!                     ║${NC}"
  echo -e "${RED}╚════════════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo "Please review the errors above and retry failed resources manually."
fi

# Cleanup
rm -rf "$TEMP_DIR"

exit 0
