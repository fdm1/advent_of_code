package y21d12

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 12)
  result := Part1(false)
  expectedResult := "10"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestGetUniquePathCountSmall(t *testing.T) {
  pathSegments := [][]string{
    []string{"start", "A"},
    []string{"start", "b"},
    []string{"A", "c"},
    []string{"A", "b"},
    []string{"b", "d"},
    []string{"A", "end"},
    []string{"b", "end"},
  }

  result := GetUniquePathCount(pathSegments)
  expectedResult := 10

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestGetUniquePathCountMedium(t *testing.T) {
  pathSegments := [][]string{
    []string{"dc", "end"},
    []string{"HN", "start"},
    []string{"start", "kj"},
    []string{"dc", "start"},
    []string{"dc", "HN"},
    []string{"LN", "dc"},
    []string{"HN", "end"},
    []string{"kj", "sa"},
    []string{"kj", "HN"},
    []string{"kj", "dc"},
  }

  result := GetUniquePathCount(pathSegments)
  expectedResult := 19

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestGetUniquePathCountLarge(t *testing.T) {
  pathSegments := [][]string{
    []string{"fs", "end"},
    []string{"he", "DX"},
    []string{"fs", "he"},
    []string{"start", "DX"},
    []string{"pj", "DX"},
    []string{"end", "zg"},
    []string{"zg", "sl"},
    []string{"zg", "pj"},
    []string{"pj", "he"},
    []string{"RW", "he"},
    []string{"fs", "DX"},
    []string{"pj", "RW"},
    []string{"zg", "RW"},
    []string{"start", "pj"},
    []string{"he", "WI"},
    []string{"zg", "he"},
    []string{"pj", "fs"},
    []string{"start", "RW"},
  }

  result := GetUniquePathCount(pathSegments)
  expectedResult := 226

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 12)
  result := Part2(false)
  expectedResult := "36"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}
