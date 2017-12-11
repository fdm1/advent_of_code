#! /bin/bash

set -eu -o pipefail

cd $(dirname $0)/..
BASE_DIR=$(pwd)

echo "cargo run --bin $1 inputs/$1.txt"
docker run --rm -it -v $BASE_DIR:/rustvent -w /rustvent/rustvent rust bash -c "cargo run --bin $1 inputs/$1.txt"
