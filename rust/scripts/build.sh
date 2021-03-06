#! /bin/bash

set -eu -o pipefail

cd $(dirname $0)/..
BASE_DIR=$(pwd)


docker run --rm -it \
  -v $BASE_DIR/../inputs:/inputs \
  -v $BASE_DIR:/rustvent \
  -v $BASE_DIR/.cargo:/root/.cargo \
  -w /rustvent/rustvent rust cargo build
