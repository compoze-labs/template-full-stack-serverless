#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/echo.sh

set -euo pipefail

PROJECT_NAME=$1
PROFILE=$2

find . -type f -name "*" \
    ! -path '*/node_modules/*' \
    ! -path "*/.git/*" \
    ! -path "*README*" \
    ! -path "*BOOTSTRAPPING*" \
    ! -path "*bootstrap.sh*" \
    -exec sed -i "s/templatenametoreplace/${PROJECT_NAME}/g" {} +

${SCRIPT_DIR}/setup-aws-profile.sh ${PROFILE}

# always ensure base is created first, as it may contain shared output
# references used by other projects
pnpm update-infra base
pnpm update-infra

AWS_PROFILE=${PROFILE} pnpm --filter api bootstrap
AWS_PROFILE=${PROFILE} pnpm --filter ui bootstrap
