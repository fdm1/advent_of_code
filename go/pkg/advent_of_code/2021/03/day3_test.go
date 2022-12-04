package y21d3

import (
  "fmt"
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 3)
  result := Part1(false)
  expectedResult := "198"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 3)
  result := Part2(false)
  expectedResult := "230"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2FilterTakeMore(t *testing.T) {
  filename := fmt.Sprintf("%v/%02d", 2021, 3)
  content := aoc_utils.ReadFile(aoc_utils.TestInput(filename))
  input := aoc_utils.InputToSlice(content)

  expectedResult := []string{}
  expectedResult = append(expectedResult, "11110", "10110", "10111", "10101", "11100", "10000", "11001")

  result := Part2Filter(input, true, 0, "1")

  for i := range result {
    if result[i] != expectedResult[i] {
      t.Fatalf("contents don't match (%v vs %v)", result, expectedResult)
    }
  }
}

func TestPart2FilterTakeLess(t *testing.T) {
  filename := fmt.Sprintf("%v/%02d", 2021, 3)
  content := aoc_utils.ReadFile(aoc_utils.TestInput(filename))
  input := aoc_utils.InputToSlice(content)

  expectedResult := []string{}
  expectedResult = append(expectedResult, "00100", "01111", "00111", "00010", "01010")

  result := Part2Filter(input, false, 0, "1")

  for i := range result {
    if result[i] != expectedResult[i] {
      t.Fatalf("contents don't match (%v vs %v)", result, expectedResult)
    }
  }
}


func TestPart2FilterOneValueLeft(t *testing.T) {
  input := []string{}
  input = append(input, "foobar")

  expectedResult := []string{}
  expectedResult = append(expectedResult, "foobar")

  result := Part2Filter(input, true, 0, "1")

  for i := range result {
    if result[i] != expectedResult[i] {
      t.Fatalf("contents don't match (%v vs %v)", result, expectedResult)
    }
  }
}

func TestPart2FilterTie(t *testing.T) {
  input := []string{}
  input = append(input, "10110", "10111")

  expectedResult := []string{}
  expectedResult = append(expectedResult, "10111")

  result := Part2Filter(input, true, 4, "1")

  for i := range result {
    if result[i] != expectedResult[i] {
      t.Fatalf("contents don't match (%v vs %v)", result, expectedResult)
    }
  }
}
