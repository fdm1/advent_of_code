YEAR=$1
DAY=$2

FILE=src/year-$1/day-$2.ts
echo "Running $FILE"
ts-node $FILE