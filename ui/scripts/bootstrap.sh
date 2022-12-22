#! /bin/bash

set -euo pipefail

PRODUCT_NAME=$1
COMPONENT_NAME=$2

APPNAME="${PRODUCT_NAME}-${COMPONENT_NAME}"

pnpm deploy:nonprod
pnpm deploy:prod

APPID=$(aws amplify list-apps | jq -r ".apps[] | select(.name==\"${APPNAME}\") | .appId")
NONPROD_UI_URL="https://nonprod.${APPID}.amplifyapp.com"
PROD_UI_URL="https://prod.${APPID}.amplifyapp.com"

find . -type f -name "*" \
    ! -path '*/node_modules/*' \
    ! -path "*/.git/*" \
    ! -path "*.md*" \
    ! -path "*bootstrap.sh*" \
    -exec sed -i "s@nonprod-ui-url-replaced-after-bootstrap@${NONPROD_UI_URL}@" {} +

find . -type f -name "*" \
    ! -path '*/node_modules/*' \
    ! -path "*/.git/*" \
    ! -path "*.md*" \
    ! -path "*bootstrap.sh*" \
    -exec sed -i "s@prod-ui-url-replaced-after-bootstrap@${PROD_UI_URL}@" {} +
