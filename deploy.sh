#!/usr/bin/env bash

# Exit on error.
set -e

# Ignore profile when in CodeBuild
export EMPTY_PROFILE=''

export CI='true'

# Uncomment for debugging.
# export SLS_DEBUG="*"
# export AWSJS_DEBUG="*"

# Stage is defined in the Cloudformation stack.
# https://github.com/tikdcom/devops/blob/master/cloudformation.yml
echo "Stage: ${STAGE}"

check() {
  (cd "$1" && npm ci && npm run lint)
}

test() {
  # Execute tests only when deploying to DEV.
  if [[ $STAGE == "dev" ]]
  then
    source .envrc && npm test
  fi
}

deploy() {
  echo "Deployment started ($1)..."
  (cd "$1" && npm run deploy -- --stage "${STAGE}")
  echo "Deployment successful ($1)..."
}

# Running checks in all projects
check microservice-a
check microservice-b


# Deploy all projects
deploy microservice-a
deploy microservice-b