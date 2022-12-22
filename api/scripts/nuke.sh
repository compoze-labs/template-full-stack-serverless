#! /bin/bash

set -uo pipefail

PRODUCT_NAME=$1
COMPONENT_NAME=$2
STACK_PREFIX="${PRODUCT_NAME}-${COMPONENT_NAME}"

sam delete --region <REGION> --no-prompts --stack-name ${STACK_PREFIX}-nonprod
sam delete --region <REGION> --no-prompts --stack-name ${STACK_PREFIX}-prod

# for some reason SAM doesn't delete everything out of our buckets :(
aws s3 rm --recursive s3://${STACK_PREFIX}-nonprod-deploymentartifacts
aws s3 rm --recursive s3://${STACK_PREFIX}-prod-deploymentartifacts
