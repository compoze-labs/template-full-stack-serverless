#! /bin/bash

set -euo pipefail

PRODUCT_NAME=$1
COMPONENT_NAME=$2

pnpm deploy:nonprod
pnpm deploy:prod

STACK_PREFIX="${PRODUCT_NAME}-${COMPONENT_NAME}"

NONPROD_BACKEND_URL=$(aws cloudformation describe-stacks --no-cli-pager | jq -r ".Stacks[] | select(.StackName==\"${STACK_PREFIX}-nonprod\").Outputs[] | select(.OutputKey==\"ApiEndpoint\").OutputValue")
PROD_BACKEND_URL=$(aws cloudformation describe-stacks --no-cli-pager | jq -r ".Stacks[] | select(.StackName==\"${STACK_PREFIX}-prod\").Outputs[] | select(.OutputKey==\"ApiEndpoint\").OutputValue")

find ../. -type f -name "*" \
    ! -path '*/node_modules/*' \
    ! -path "*/.git/*" \
    ! -path "*.md*" \
    ! -path "*bootstrap.sh*" \
    -exec sed -i "s@nonprod-backend-api-replaced-after-bootstrap@${NONPROD_BACKEND_URL}@" {} +

find ../. -type f -name "*" \
    ! -path '*/node_modules/*' \
    ! -path "*/.git/*" \
    ! -path "*.md*" \
    ! -path "*bootstrap.sh*" \
    -exec sed -i "s@prod-backend-api-replaced-after-bootstrap@${PROD_BACKEND_URL}@" {} +
