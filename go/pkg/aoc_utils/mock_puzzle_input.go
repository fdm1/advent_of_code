package aoc_utils

import (
  "fmt"
  "github.com/jarcoal/httpmock"
)

func MockAdventOfCodeInput(year int, day int) {
  httpmock.Activate()

  url := fmt.Sprintf("https://adventofcode.com/%v/day/%d/input", year, day)
  filename := fmt.Sprintf("%v/%02d", year, day)
  content := ReadFile(TestInput(filename))

  httpmock.RegisterResponder("GET", url,
    httpmock.NewStringResponder(200, content))
}
