# Advent of Code - Golang edition

## Run tests:

Iterate through all `cmd` and `pkg` dirs, and run any tests that exist.

```
./bin/go_tests.sh
```

## Run a puzzle:

Create a `.env` file to set `AOC_SESSION` (or set it in the environment), getting the session cookie from advent of code after logging in. This is required to download the input at runtime.

Use the bin script to run a puzzle. It will prompt for a year, day, and part, and if a solution is attempted, it will return that result.

```
./bin/run_puzzle.sh

> Year: 2020
> Day: 1
> Part: 2
> Result: 236430480
```

## Add new puzzle solutions

- Add the a test input file to `..test_inputs//<YEAR>/<LEFT-PADDED DAY>.txt`)
- Add a solution in a `.go` file in `pkg/advent_of_code`. The function to solve the problem must be typed `func(string) string`, taking a filename, and returing a string representation of the answer.
- Add the mapping to the function in `pkg/advent_of_code/puzzle_map.go` with the key as `<YEAR>-<DAY>-<PART>` and the value as the name of the function (e.g. `"2020-1-2": Year2020Day1Part2`)
