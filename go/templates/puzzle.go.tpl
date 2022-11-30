package yYEARdDAY

import (
  "fmt"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(YEAR, DAY, cache)
  input := aoc_utils.InputToSlice(content)
  return fmt.Sprintf("%v", input)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(YEAR, DAY, cache)
  input := aoc_utils.InputToSlice(content)
  return fmt.Sprintf("%v", input)
}
