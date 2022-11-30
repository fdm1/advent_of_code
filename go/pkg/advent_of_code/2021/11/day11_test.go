package y21d11

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 11)
  result := Part1(false)
  expectedResult := "1656"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 11)
  result := Part2(false)
  expectedResult := "195"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestIterate(t *testing.T) {
  intRows := [][]int{
    []int{1, 1, 1, 1, 1},
    []int{1, 9, 9, 9, 1},
    []int{1, 9, 1, 9, 1},
    []int{1, 9, 9, 9, 1},
    []int{1, 1, 1, 1, 1},
  }
  expectedIntRows := [][]int{
    []int{3, 4, 5, 4, 3},
    []int{4, 0, 0, 0, 4},
    []int{5, 0, 0, 0, 5},
    []int{4, 0, 0, 0, 4},
    []int{3, 4, 5, 4, 3},
  }

  result, flashes := Iterate(intRows)
  for row, rowVal := range result {
    for col, _ := range rowVal {
      if result[row][col] != expectedIntRows[row][col] {
        t.Fatalf("actual result %v != expected result %v", result, expectedIntRows)
      }
    }
  }
  if flashes != 9 {
    t.Fatalf("actual flashes %v != expected flashes 9", flashes)
  }
}
