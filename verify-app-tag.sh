#!/bin/bash
#############################################################################
# Script: verify-app-tags.sh
# Purpose: Verify that app_name tags have been applied to all resources
# Project: onelens-4786099461
#############################################################################

set -e

PROJECT="onelens-4786099461"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         Resource Tagging Verification Script                  ║"
echo "║         Project: onelens-4786099461                           ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Get all resources
echo "Fetching all resources from project..."
raptor get resources --project "$PROJECT" -o json > /tmp/all-resources.json

# Count resources by app_name
ONYX_COUNT=$(jq -r '.[] | select(.spec.app_name == "onyx") | .metadata.name' /tmp/all-resources.json 2>/dev/null | wc -l)
ONELENS_COUNT=$(jq -r '.[] | select(.spec.app_name == "onelens") | .metadata.name' /tmp/all-resources.json 2>/dev/null | wc -l)
SHARED_COUNT=$(jq -r '.[] | select(.spec.app_name == "shared") | .metadata.name' /tmp/all-resources.json 2>/dev/null | wc -l)
NO_TAG_COUNT=$(jq -r '.[] | select(.spec.app_name == null or .spec.app_name == "") | .metadata.name' /tmp/all-resources.json 2>/dev/null | wc -l)
TOTAL_COUNT=$(jq -r '.[] | .metadata.name' /tmp/all-resources.json 2>/dev/null | wc -l)

echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}                   TAGGING SUMMARY                              ${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}✓ ONYX Resources (app_name: onyx):        ${ONYX_COUNT}${NC}"
echo -e "${GREEN}✓ ONELENS Resources (app_name: onelens):  ${ONELENS_COUNT}${NC}"
echo -e "${GREEN}✓ SHARED Resources (app_name: shared):    ${SHARED_COUNT}${NC}"
echo -e "${RED}✗ Untagged Resources (no app_name):       ${NO_TAG_COUNT}${NC}"
echo ""
echo -e "${BLUE}Total Resources: ${TOTAL_COUNT}${NC}"
echo ""

# Expected counts
EXPECTED_ONYX=86
EXPECTED_ONELENS=7
EXPECTED_SHARED=20

echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}                EXPECTED vs ACTUAL                              ${NC}"
echo -e "${YELLOW}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo "ONYX:     Expected: ${EXPECTED_ONYX}, Actual: ${ONYX_COUNT}"
echo "ONELENS:  Expected: ${EXPECTED_ONELENS}, Actual: ${ONELENS_COUNT}"
echo "SHARED:   Expected: ${EXPECTED_SHARED}, Actual: ${SHARED_COUNT}"
echo ""

# List untagged resources if any
if [ $NO_TAG_COUNT -gt 0 ]; then
  echo -e "${RED}════════════════════════════════════════════════════════════════${NC}"
  echo -e "${RED}            UNTAGGED RESOURCES (NEEDS ATTENTION)                ${NC}"
  echo -e "${RED}════════════════════════════════════════════════════════════════${NC}"
  echo ""
  jq -r '.[] | select(.spec.app_name == null or .spec.app_name == "") | "\(.kind)/\(.metadata.name)"' /tmp/all-resources.json
  echo ""
fi

# List sample tagged resources for verification
echo -e "${GREEN}════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}        SAMPLE TAGGED RESOURCES (First 10 of each)              ${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${BLUE}ONYX Resources:${NC}"
jq -r '.[] | select(.spec.app_name == "onyx") | "  ✓ \(.kind)/\(.metadata.name) (cost_center: \(.spec.cost_center // "N/A"))"' /tmp/all-resources.json | head -10
echo ""

echo -e "${BLUE}ONELENS Resources:${NC}"
jq -r '.[] | select(.spec.app_name == "onelens") | "  ✓ \(.kind)/\(.metadata.name) (cost_center: \(.spec.cost_center // "N/A"))"' /tmp/all-resources.json | head -10
echo ""

echo -e "${BLUE}SHARED Resources:${NC}"
jq -r '.[] | select(.spec.app_name == "shared") | "  ✓ \(.kind)/\(.metadata.name) (cost_center: \(.spec.cost_center // "N/A"))"' /tmp/all-resources.json | head -10
echo ""

# Export tagged resources to CSV for analysis
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}               EXPORTING TO CSV                                 ${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo ""

CSV_FILE="/tmp/facets-resource-tags.csv"
echo "Resource Type,Resource Name,App Name,Cost Center,Flavor,Version" > "$CSV_FILE"
jq -r '.[] | [.kind, .metadata.name, (.spec.app_name // "UNTAGGED"), (.spec.cost_center // "N/A"), .flavor, .version] | @csv' /tmp/all-resources.json >> "$CSV_FILE"

echo -e "${GREEN}✓ Exported to: ${CSV_FILE}${NC}"
echo ""

# Final status
if [ $NO_TAG_COUNT -eq 0 ]; then
  echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║          ALL RESOURCES ARE PROPERLY TAGGED! ✓                  ║${NC}"
  echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
  exit 0
else
  echo -e "${RED}╔════════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${RED}║     WARNING: ${NO_TAG_COUNT} RESOURCES ARE NOT TAGGED!                    ║${NC}"
  echo -e "${RED}╚════════════════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo "Please review untagged resources and run add-app-tags.sh again."
  exit 1
fi
