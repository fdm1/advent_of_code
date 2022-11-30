package y21d10

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 10)
  result := Part1(false)
  expectedResult := "26397"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 10)
  result := Part2(false)
  expectedResult := "288957"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestFindIllegalChar(t *testing.T) {
  result, _ := FindIllegalChar("{([(<{}[<>[]}>{[]{[(<()>")
  expectedResult := "}"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestScoreForAutocomplete(t *testing.T) {
  result := ScoreForAutocomplete([]string{"[", "(", "{", "(", "[", "[", "{", "{"})
  expectedResult := 288957

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}
