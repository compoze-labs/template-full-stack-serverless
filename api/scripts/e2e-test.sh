#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR/.."
ENVIRONMENTS_DIR="${PROJECT_DIR}/environments"

if [ -z "${ENV:-}" ]; then
    echo "ENV is not set. Please set ENV to the environment you want to deploy to."
    exit 1
fi

# Check if ENV exists, if not, log error and exit
if [ ! -f "${ENVIRONMENTS_DIR}/${ENV}.env" ]; then
  echo "Environment ${ENV} does not exist"
  exit 1
fi

newman run "${PROJECT_DIR}/e2e/collection.postman_collection.json" -e "${PROJECT_DIR}/e2e/${ENV}.postman_environment.json" --bail