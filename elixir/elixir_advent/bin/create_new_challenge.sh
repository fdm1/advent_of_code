#! /bin/bash
set -eu -o pipefail

cd $(dirname $0)/..
BASE_DIR=$(pwd)

if [ "$#" -ne 2 ]; then
    echo "usage: create_new_challenge.sh <year> <day>"
fi

YYYY=$1
D=$(echo $2 | sed 's/0*//g')
NN=$(printf "%02d\n" $2)

LIB_CODE=lib/year_${YYYY}/day_${NN}.ex
TEST_CODE=test/test_year_${YYYY}/day_${NN}_test.exs

mkdir -p lib/year_${YYYY}
mkdir -p test/test_year_${YYYY}

cp day_NN.ex.tpl ${LIB_CODE}
cp day_NN_test.exs.tpl ${TEST_CODE}

sed -i '' "s/YYYY/${YYYY}/g" ${LIB_CODE}
sed -i '' "s/YYYY/${YYYY}/g" ${TEST_CODE}
sed -i '' "s/NN/${NN}/g" ${LIB_CODE}
sed -i '' "s/NN/${NN}/g" ${TEST_CODE}
sed -i '' "s/day\/D/day\/${D}/g" ${LIB_CODE}
