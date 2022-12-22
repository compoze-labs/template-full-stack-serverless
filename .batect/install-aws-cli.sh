#!/bin/bash

set -euo pipefail

ARCH=$(dpkg --print-architecture)

if [ "${ARCH}" = "amd64" ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
fi

if [ "${ARCH}" = "armhf" ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
fi 

if [ "${ARCH}" = "arm64" ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
fi

unzip awscliv2.zip
sudo ./aws/install