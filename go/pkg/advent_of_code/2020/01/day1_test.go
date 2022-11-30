package y20d1

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2020, 1)
  result := Part1(false)
  expectedResult := "514579"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2020, 1)
  result := Part2(false)
  expectedResult := "241861950"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestFilterInts(t *testing.T) {
  inputs := []int{}
  inputs = append(inputs, 1)
  inputs = append(inputs, 2)
  inputs = append(inputs, 3)

  expectedResult := []int{}
  expectedResult = append(expectedResult, 1)
  expectedResult = append(expectedResult, 2)


  result := FilterInts(3, inputs)

  for i := range result {
    if result[i] != expectedResult[i] {
      t.Fatalf("contents don't match (%v vs %v)", result, expectedResult)
    }
  }
}
