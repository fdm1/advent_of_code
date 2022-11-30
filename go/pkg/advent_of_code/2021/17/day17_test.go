package y2021d17

import (
  "testing"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func TestPart1(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 17)
  result := Part1(false)
  expectedResult := "45"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPart2(t *testing.T) {
  aoc_utils.MockAdventOfCodeInput(2021, 17)
  result := Part2(false)
  expectedResult := "112"

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPastEndZoneTooShortAndLow(t *testing.T) {
  xRange := []int{20, 30}
  yRange := []int{-10, -5}
  result := PastEndZone(19, -11, xRange, yRange)
  expectedResult := true

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPastEndZoneTooFarAndLow(t *testing.T) {
  xRange := []int{20, 30}
  yRange := []int{-10, -5}
  result := PastEndZone(31, -11, xRange, yRange)
  expectedResult := true

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPastEndZoneHigh(t *testing.T) {
  xRange := []int{20, 30}
  yRange := []int{-10, -5}
  result := PastEndZone(25, -4, xRange, yRange)
  expectedResult := false

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestPastEndZoneShort(t *testing.T) {
  xRange := []int{20, 30}
  yRange := []int{-10, -5}
  result := PastEndZone(19, -9, xRange, yRange)
  expectedResult := false

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestInEndZoneTrue(t *testing.T) {
  xRange := []int{20, 30}
  yRange := []int{-10, -5}
  result := InEndZone(22, -8, xRange, yRange)
  expectedResult := true

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

func TestInEndZoneFalse(t *testing.T) {
  xRange := []int{20, 30}
  yRange := []int{-10, -5}
  result := InEndZone(18, -8, xRange, yRange)
  expectedResult := false

  if result != expectedResult {
    t.Fatalf("actual result %v != expected result %v", result, expectedResult)
  }
}

