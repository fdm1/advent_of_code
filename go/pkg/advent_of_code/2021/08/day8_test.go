package y21d8

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 8)
  result := Part1(false)
  expectedResult := "26"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 8)
  result := Part2(false)
  expectedResult := "61229"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestDecodeRow(t *testing.T) {
  row := "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
  result := DecodeRow(row)
  expectedResult := 5353

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestDecodeRowMore(t *testing.T) {
  row := "bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef"
  result := DecodeRow(row)
  expectedResult := 1625

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestDecodeRowEarlyReturn(t *testing.T) {
  row := "stuf | aa abc cadb cdfebaf"
  result := DecodeRow(row)
  expectedResult := 1748

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}
