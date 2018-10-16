#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

release_version=$1
next_version=$2-SNAPSHOT

echo -e "Releasing version ${RED} $release_version ${NC} and preparing next version ${GREEN} $next_version ${NC}"

curl \
  --header "Content-Type: application/json" \
  --data '{"build_parameters": {"RELEASE_VERSION": "$release_version", "NEXT_VERSION": "$next_version"}}' \
  --request POST \
                https://circleci.com/api/v1.1/project/github/cvgaviao/c8tech-releng-maven/tree/master?circle-token=$CIRCLE_TOKEN

  