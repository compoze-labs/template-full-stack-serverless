#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR/.."
ENVIRONMENTS_DIR="${PROJECT_DIR}/environments"

get_environment_vars() {
    ENV=$1
    echo "getting environments for $ENV"
    environments=""
    while read -r line || [ -n "$line" ]; do
        environments+="$line "
    done <"${ENVIRONMENTS_DIR}/${ENV}.env"
}

PRODUCT_NAME=$1
COMPONENT_NAME=$2
BUCKET_NAME=$3

DEPLOYMENT_BUCKET="${BUCKET_NAME}.${ENV}"
STACK_PREFIX="${PRODUCT_NAME}-${COMPONENT_NAME}"
STACK_NAME="${STACK_PREFIX}-${ENV}"

# check if environment variable, ENV, is set. If not, print error and exit
if [ -z "${ENV:-}" ]; then
    echo "ENV is not set. Please set ENV to the environment you want to deploy to."
    exit 1
fi

pnpm clean
pnpm build

echo "setting appropriate read permissions" # https://acloud.guru/forums/aws-lambda/discussion/-KSVv58PhKhA1c6a6EZ-/errormessage-eacces-permission-denied-open-vartaskcsvreadjs
chmod -R 744 deploy

get_environment_vars $ENV

echo $environments

sam deploy --stack-name ${STACK_NAME} \
    --template "${PROJECT_DIR}/template.yml" \
    --s3-bucket "${DEPLOYMENT_BUCKET}" \
    --capabilities CAPABILITY_IAM \
    --no-fail-on-empty-changeset \
    --region <REGION> \
    --parameter-overrides "$environments"
