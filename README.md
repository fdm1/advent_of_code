Repo for working through [Advent of Code](http://adventofcode.com)

### Progress

![badge](https://img.shields.io/endpoint?label=Total%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_total.json)
- ![badge](https://img.shields.io/endpoint?label=2015%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2015.json)
- ![badge](https://img.shields.io/endpoint?label=2016%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2016.json)
- ![badge](https://img.shields.io/endpoint?label=2017%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2017.json)
- ![badge](https://img.shields.io/endpoint?label=2018%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2018.json)
- ![badge](https://img.shields.io/endpoint?label=2019%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2019.json)
- ![badge](https://img.shields.io/endpoint?label=2020%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2020.json)
- ![badge](https://img.shields.io/endpoint?label=2021%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2021.json)
- ![badge](https://img.shields.io/endpoint?label=2022%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2022.json)
- ![badge](https://img.shields.io/endpoint?label=2023%20Stars%20%E2%AD%90&url=https%3A%2F%2Fgist.githubusercontent.com%2Ffdm1%2F88c3907f142f24c32e91ce1dc79729f3%2Fraw%2Faoc_stars_2023.json)

### Attempted in various languages

(either ones I know, or ones I have no clue what I'm doing with). Some more earnest attempts than others.

- Ruby
- Python
- Golang
- Rust
- Elixir
- Typescript

### General setup:

- store session token in `.aoc_token`
- language setup is specific to the languages. Ones that haven't been done in a while might need some love.

### Patterns to follow:

- share test inputs in `test_input/<YEAR>/<0-padded DAY>.txt`
- share inputs in `inputs/<YEAR>/<0-padded DAY>.txt`
- Download the file if it doesn't exist in the language puzzle runner.:

### Readme stars action setup:

- Create a new fine-grained access token for the action to use. This token needs read and write access to gists

- In the repo actions secrets:
  - AOC_SESSION: Same value as what's in `.aoc_token`. This needs to be updated from time to time.
  - AOC_USERID: Can be found by viewing your own private leaderboard. This should be the end of the url.
  - AOC_USER_AGENT: Maybe any string will do?
  - GIST_ID: The id of a gist to store the json results
  - GIST_SECRET: The gist access token created above

