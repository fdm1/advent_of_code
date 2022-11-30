package y21d2

import (
  "strconv"
  "strings"

  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 2, cache)
  input := aoc_utils.InputToSlice(content)
  horizontal := 0
  depth := 0

  for _, val := range input {
    cmdSlice := strings.Split(val, " ")
    cmd := cmdSlice[0]
    amt, _ := strconv.Atoi(cmdSlice[1])
    if cmd == "forward" {
      horizontal += amt
    } else if cmd == "up" {
      depth -= amt
    } else {
      depth += amt
    }
  }

  return strconv.Itoa(horizontal * depth)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 2, cache)
  input := aoc_utils.InputToSlice(content)
  horizontal := 0
  depth := 0
  aim := 0

  for _, val := range input {
    cmdSlice := strings.Split(val, " ")
    cmd := cmdSlice[0]
    amt, _ := strconv.Atoi(cmdSlice[1])
    if cmd == "forward" {
      depth += (amt * aim)
      horizontal += amt
    } else if cmd == "up" {
      aim -= amt
    } else {
      aim += amt
    }
  }

  return strconv.Itoa(horizontal * depth)
}
