#! /bin/bash
set -eu -o pipefail

if [ "$#" -ne 3 ] && [ "$#" -ne 4 ]; then
    echo "usage: run.sh <year> <day> <part> [input file]"
fi

cd $(dirname $0)/..
BASE_DIR=$(pwd)

YEAR=$1
DAY=$(printf "%02d\n" $2)
PART=$3
INPUT=""

if [ "$#" -eq 4 ]; then
    INPUT=$4
fi

mix escript.build
./elixir_advent $YEAR $DAY $PART $INPUT