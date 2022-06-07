#!/usr/bin/env bash

DIRNAME=$(dirname "$0")
source "${DIRNAME}/.env"

DOCKER=docker

while getopts "b:a" opt; do
    # shellcheck disable=SC2220
    case "$opt" in
        b) BRANCH=$OPTARG
           ;;
        a) APP=1
           ;;
   esac
done

if [ -z "${BRANCH}" ]; then
    echo "You have to specify the branch!"
    exit 1
fi

[[ $APP == 1 ]] && \
    ${DOCKER} run --rm -d \
        --net "${NETWORK_NAME}" \
        --name "${PROJECT_NAME}-${BRANCH}" \
        -e VIRTUAL_HOST="${BRANCH}.${DOMAIN}" \
        ${PROJECT_NAME}:${BRANCH}

