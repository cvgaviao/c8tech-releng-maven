#!/usr/bin/env bash


if [[ ! -n "$CIRCLE_TOKEN" ]]; then
    echo "You must export CIRCLE_TOKEN environment variable before run." 1>&2
    exit 1
fi    

if [[ ! -n "$1"  ||  ! -n "$2" ]]; then
        echo "Both release version (argument 1) and next version (argument 2) should be informed" 1>&2
        exit 1
fi



RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

release_version=$1
next_version=$2

echo -e "Releasing version ${RED} $release_version ${NC} and preparing next version ${GREEN} $next_version ${NC}"

template_parameter='{"build_parameters": {"RELEASE_VERSION": "%s", "NEXT_VERSION": "%s"}}'
json_parameter=$(printf "$template_parameter" "$1" "$2")

curl \
  --header "Content-Type: application/json" \
  --data "$json_parameter" \
  --request POST \
                https://circleci.com/api/v1.1/project/github/cvgaviao/c8tech-releng-maven/tree/master?circle-token=$CIRCLE_TOKEN

  