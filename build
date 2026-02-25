#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  source .env
else
  echo "Error: .env file not found!"
  exit 1
fi
TAG=16.16.2

#docker build --no-cache -t freepbx-docker-unimrcp:$TAG .  --build-arg UNIMRCP_USER="${UNIMRCP_USER}"  --build-arg UNIMRCP_PASS="${UNIMRCP_PASS}"

docker build -t freepbx-docker-unimrcp:$TAG .  --build-arg UNIMRCP_USER="${UNIMRCP_USER}"  --build-arg UNIMRCP_PASS="${UNIMRCP_PASS}"

