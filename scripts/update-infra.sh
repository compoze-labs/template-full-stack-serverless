#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/echo.sh

set -euo pipefail

PROJECT_NAME=$1
PROFILE=$2

function update {
    FILE=$1
    STACK_NAME=$2

    set +e
    OUTPUT=$(aws cloudformation update-stack \
        --profile ${PROFILE} \
        --stack-name ${STACK_NAME} \
        --parameters "ParameterKey=ProjectName,ParameterValue=${PROJECT_NAME}" \
        --template-body file://${FILE} \
        --capabilities CAPABILITY_NAMED_IAM \
        --no-cli-pager 2>&1 \
    )
    RESULT=$?
    set -e

    if [ $RESULT -eq 0 ]; then
        echo "$OUTPUT"
        note "Waiting for cloudformation stack ${STACK_NAME} to be updated..."
        aws cloudformation wait stack-update-complete \
            --profile ${PROFILE} \
            --stack-name ${STACK_NAME}
        headline "Successfully updated ${STACK_NAME}!"
    else
        if echo "$OUTPUT" | grep -q "No updates are to be performed"; then
            headline "${STACK_NAME} is up-to-date!"
        else
            if echo "$OUTPUT" | grep -q "does not exist"; then
                aws cloudformation create-stack \
                    --profile ${PROFILE} \
                    --stack-name ${STACK_NAME} \
                    --parameters "ParameterKey=ProjectName,ParameterValue=${PROJECT_NAME}" \
                    --template-body file://${FILE} \
                    --capabilities CAPABILITY_NAMED_IAM \
                    --no-cli-pager
                note "Waiting for cloudformation stack ${STACK_NAME} to be created..."
                aws cloudformation wait stack-create-complete \
                    --profile ${PROFILE} \
                    --stack-name ${STACK_NAME}
                headline "Successfully created ${STACK_NAME}!"
            else
                echo "$OUTPUT"
                exit 1
            fi
        fi
    fi
}

# always ensure base is updated first, as it may contain shared output
# references used by other projects
update "infrastructure/base.yml" "${PROJECT_NAME}-base"

FILES="infrastructure/*"
for f in $FILES
do
    note "Processing $f..."
    STACK=${f/"infrastructure/"/""}
    STACK=${STACK/".yml"/""}
    STACK=${STACK/".yaml"/""}
    STACK_NAME="${PROJECT_NAME}-${STACK}"

    update $f $STACK_NAME

done