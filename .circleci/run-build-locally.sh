#!/usr/bin/env bash

echo "building from commit " $1 

curl --user ${CIRCLE_TOKEN}: \
    --request POST \
    --form revision=$1\
    --form config=@config.yml \
    --form notify=false \
        https://circleci.com/api/v1.1/project/github/cvgaviao/c8tech-releng-maven/tree/master
        
        