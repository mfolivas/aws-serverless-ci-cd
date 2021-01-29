#!/usr/bin/env bash

# Exit on error.
set -e

# Ignore profile when in CodeBuild
export EMPTY_PROFILE=''

export CI='true'

echo "Stage: ${STAGE}"

check() {
  (cd "$1" && npm ci && npm run lint)
}

test() {
  # Execute tests only when deploying to DEV.
  if [[ $STAGE == "dev" ]]
  then
    # source .envrc && npm test
    npm test
  fi
}

deploy() {
  echo "Deployment started ($1)..."
  (cd "$1" && npm run deploy -- --stage "${STAGE}")
  echo "Deployment successful ($1)..."
}

# Running checks in all projects
check microservice-a
# check microservice-b

# Running test as long as we're in stage
test microservice-a
# test microservice-b

# Deploy all projects
deploy microservice-a
# deploy microservice-b