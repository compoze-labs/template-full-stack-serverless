#!/bin/bash

set -euo pipefail

ENV=$1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR/.."

# Check if ENV exists, if not, log error and exit
if [ ! -f "${ENVIRONMENTS_DIR}/${ENV}.env" ]; then
  echo "Environment ${ENV} does not exist"
  exit 1
fi

echo "Generating e2e environment ${ENV}..."
( cd $PROJECT_DIR ; ./scripts/generate-e2e-env.sh $ENV && npm run test:e2e )