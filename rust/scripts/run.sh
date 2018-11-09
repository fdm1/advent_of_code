#! /bin/bash

set -eu -o pipefail

if [ "$#" -ne 2 ]; then
    echo "usage: run.sh <year> <day>"
fi

cd $(dirname $0)/..
BASE_DIR=$(pwd)

RUST_CLASS=$1day$2
INPUT=/inputs/$1/$(printf "%02d\n" $2).txt

echo "cargo run --bin ${RUST_CLASS} ${INPUT}"
docker run --rm -it \
  -v $BASE_DIR/../inputs:/inputs \
  -v $BASE_DIR:/rustvent \
  -v $BASE_DIR/.cargo:/root/.cargo \
  -w /rustvent/rustvent rust bash -c "cargo run --bin ${RUST_CLASS} ${INPUT}"
