package y21d13

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 13)
  result := Part1(false)
  expectedResult := "17"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 13)
  result := Part2(false)
  expectedResult := "\n#####\n#   #\n#   #\n#   #\n#####\n     \n     \n"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}
