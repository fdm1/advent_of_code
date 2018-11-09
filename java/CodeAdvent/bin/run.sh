#! /bin/bash
set -eu -o pipefail

if [ "$#" -ne 2 ] && [ "$#" -ne 3 ]; then
    echo "usage: run.sh <year> <day> [input file]"
fi

cd $(dirname $0)/..
BASE_DIR=$(pwd)

YEAR=$1
DAY=$(printf "%02d\n" $2)
INPUT=""

if [ "$#" -eq 3 ]; then
    INPUT=$3
fi

gradle build -xtest
java -cp ${BASE_DIR}/build/classes/java/main CodeAdventMain $YEAR $DAY $INPUT
