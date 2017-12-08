#! /bin/bash

set -eu -o pipefail

cd $(dirname $0)/..
BASE_DIR=$(pwd)

docker run --rm -it -v $BASE_DIR:/rustvent -w /rustvent/rustvent rust
