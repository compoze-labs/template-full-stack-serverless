#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/echo.sh

set -euo pipefail

PROFILE=$1

set +u
if [[ -z ${JUST_DO_IT} ]]; then
    set -u
    if ! cat ~/.aws/credentials | grep -q "\[${PROFILE}\]"; then
        headline "Setting up your AWS profile (${PROFILE})."
        note "Log in to AWS and go to Security Credentials to create your access key."
        aws configure --profile ${PROFILE}
        note "Saved AWS credentials underneath ~/.aws/credentials."
        headline "Successfully set up your AWS profile!"
    else
        headline "${PROFILE} is already set up :)"
    fi
fi
set -u