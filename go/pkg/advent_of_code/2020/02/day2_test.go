package y20d2

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2020, 2)
  result := Part1(false)
  expectedResult := "2"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2020, 2)
  result := Part2(false)
  expectedResult := "1"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestParseInputLine(t *testing.T) {
  inputLine := "1-3 b: cdefg"

  minCount, maxCount, char, password := ParseInputLine(inputLine)

  if minCount != 1 {
    t.Fatalf("actual minCount %v != 1", minCount)
  }

  if maxCount != 3 {
    t.Fatalf("actual maxCount %v != 1", maxCount)
  }

  if char != "b" {
    t.Fatalf("actual char %v != 1", char)
  }

  if password != "cdefg" {
    t.Fatalf("actual password %v != 1", password)
  }


}
