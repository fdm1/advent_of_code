#! /bin/bash


set -eu -o pipefail

cd $(dirname $0)/..
BASE_DIR=$(pwd)

if [[ $# < 1 ]]; then
  TEST=''
else
  TEST=$!
fi

export TOXENV=$TEST

docker-compose -f docker-compose.tox.yaml up
