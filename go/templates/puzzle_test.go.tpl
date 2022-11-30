package yYEARdDAY

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(YEAR, DAY)
  result := Part1(false)
  expectedResult := "part1_answer"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

// func TestPart2(t *testing.T) {
//   aoc_utils.MockAdventOfCodeInput(YEAR, DAY)
//   result := Part2(false)
//   expectedResult := "part2_answer"
//
//   if result != expectedResult {
//     t.Fatalf("actual result %v != expected result %v", result, expectedResult)
//   }
// }
