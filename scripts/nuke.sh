#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/echo.sh

set -euo pipefail

PROJECT_NAME=$1
PROFILE=$2

function nuke {
    STACK_TO_NUKE="${PROJECT_NAME}-${1}"
    aws cloudformation delete-stack \
            --profile ${PROFILE} \
            --stack-name ${STACK_TO_NUKE} \
            --no-cli-pager
    note "Waiting for cloudformation stack ${STACK_TO_NUKE} to be deleted..."
    aws cloudformation wait stack-delete-complete \
        --profile ${PROFILE} \
        --stack-name ${STACK_TO_NUKE} \
        --color on
    headline "Successfully deleted ${STACK_TO_NUKE}"
}

function areYouSure {
    set +u
    if [[ -z ${JUST_DO_IT} ]]; then
        warning "Are you sure you wish to nuke this?"
        warning "This will tear down all infrastructure."
        read -p "(y/N): " ARE_YOU_SURE
        if [ ${ARE_YOU_SURE} = "N" ]; then
            note "Cancelling..."
            exit 1
        fi
    fi
    set -u
}

set +u
NUKE_ONLY=$3

if [[ -z ${NUKE_ONLY} ]]; then
    set -u
    note "Preparing to nuke EVERYTHING"
    areYouSure

    AWS_PROFILE=${PROFILE} pnpm -r nuke

    FILES="infrastructure/*"
    for f in $FILES
    do
        if [ "$f" != "infrastructure/base.yml" ]; then
            note "Processing $f..."
            STACK=${f/"infrastructure/"/""}
            STACK=${STACK/".yml"/""}
            STACK=${STACK/".yaml"/""}
            nuke ${STACK}
        fi
    done
    
    # nuke base last since it contains things that may be referenced
    # by other stacks
    nuke "base"
else
    set -u
    note "Preparing to nuke: ${NUKE_ONLY}"
    areYouSure

    AWS_PROFILE=${PROFILE} pnpm --filter ${NUKE_ONLY} -r nuke
    
    note "Processing infrastructure/$NUKE_ONLY.yml..."
    nuke ${NUKE_ONLY}
fi