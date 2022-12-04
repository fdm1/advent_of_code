Repo for working through [Advent of Code](http://adventofcode.com)

Years/languages (some attempts are very meager, maybe just for testing setups before the year started)

- 2015
  - Elixir
  - Python
- 2017
  - Python
  - Rust
- 2019
  - Typescript
- 2020
  - Go
- 2021
  - Go (record 17 days)
- 2022
  - Ruby

General setup:
- store session token in `.aoc_token`
- language setup is specific to the languages. Ones that haven't been done in a while might need some love.

Patterns to follow:
- share test inputs in `test_input/<YEAR>/<0-padded DAY>.txt`
- share inputs in `inputs/<YEAR>/<0-padded DAY>.txt`
- Download the file if it doesn't exist in the language puzzle runner.
