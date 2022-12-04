#! /bin/bash

YEAR=$1
DAY=$2

if [[ -z ${YEAR} || -z ${DAY} ]]; then
  echo "Usage: ./bin/add_puzzle.sh <YEAR> <DAY>"
  exit 0
fi

printf -v LEFT_PADDED_DAY "%02d" ${DAY}
PUZZLE_DIR=pkg/advent_of_code/${YEAR}/${LEFT_PADDED_DAY}
PUZZLE_FILE=${PUZZLE_DIR}/day${DAY}.go
TEST_FILE=${PUZZLE_DIR}/day${DAY}_test.go
TEST_INPUT_FILE=../test_input/${YEAR}/${LEFT_PADDED_DAY}.txt

PUZZLE_MAP_FILE=pkg/advent_of_code/puzzle_map.go
IMPORT_BREAKPOINT_STRING="\^\)"
IMPORT_ADDITION="  \"github.com/fdm1/advent_of_code_go/${PUZZLE_DIR}\"\n\)"
PUZZLE_MAP_BREAKPOINT_STRING="  }"
PUZZLE_MAP_ADDITION=$(cat <<EOF
    "${YEAR}-${DAY}-1": y${YEAR}d${DAY}.Part1,
    "${YEAR}-${DAY}-2": y${YEAR}d${DAY}.Part2,
${PUZZLE_MAP_BREAKPOINT_STRING}
EOF
)

# if file doesn't exist

if [[ -e ${PUZZLE_FILE} ]]; then
  echo ${PUZZLE_FILE} already exists. Aborting
else
  mkdir -p ${PUZZLE_DIR}
  echo Creating files for ${YEAR}-${DAY}
  cp templates/puzzle.go.tpl ${PUZZLE_FILE}
  cp templates/puzzle_test.go.tpl ${TEST_FILE}
  echo "insert input here" > ${TEST_INPUT_FILE}

  perl -i -pe "s/YEAR/${YEAR}/g" ${PUZZLE_FILE}
  perl -i -pe "s/YEAR/${YEAR}/g" ${TEST_FILE}
  perl -i -pe "s/DAY/${DAY}/g" ${PUZZLE_FILE}
  perl -i -pe "s/DAY/${DAY}/g" ${TEST_FILE}

  perl -i -pe "s^${IMPORT_BREAKPOINT_STRING}^${IMPORT_ADDITION}^g" ${PUZZLE_MAP_FILE}
  perl -i -pe "s/${PUZZLE_MAP_BREAKPOINT_STRING}/${PUZZLE_MAP_ADDITION}/g" ${PUZZLE_MAP_FILE}
fi
