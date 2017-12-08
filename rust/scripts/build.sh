#! /bin/bash

set -eu -o pipefail

cd $(dirname $0)/..
BASE_DIR=$(pwd)

docker run --rm -v $BASE_DIR:/rustvent -w /rustvent/rustvent rust cargo build
