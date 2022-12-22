#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/echo.sh

set -euo pipefail

PROFILE=$1

note "Configuring NPM to be latest..."
NVM_DIR=${HOME}/.nvm && source ${NVM_DIR}/nvm.sh && nvm install --latest-npm && nvm use --latest-npm

note "Configuring git hooks..."
git config core.hooksPath .githooks

note "Ensuring teams AWS profile exists..."
${SCRIPT_DIR}/setup-aws-profile.sh ${PROFILE}

note "Ensuring pnpm is installed..."
npm install -g pnpm

headline "Done!"