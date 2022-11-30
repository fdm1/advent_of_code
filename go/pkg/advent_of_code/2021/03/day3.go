package y21d3

import (
  "strconv"
  "strings"
  "fmt"

  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 3, cache)
  input := aoc_utils.InputToSlice(content)
  counts := make([]int, len(strings.Split(input[0], "")))

  for _, val := range input {
    binaryRow := strings.Split(val, "")
    for i, binaryVal := range binaryRow {
      if binaryVal == "1" {
        counts[i] += 1
      }
    }
  }

  epsilonBinary := ""
  gammaBinary := ""

  for _, val := range counts {
    mostAreOne := val >= len(input) / 2
    if mostAreOne {
      epsilonBinary += "0"
      gammaBinary += "1"
    } else {
      epsilonBinary += "1"
      gammaBinary += "0"
    }
  }

  epsilon, _ := strconv.ParseInt(epsilonBinary, 2, 64)
  gamma, _ := strconv.ParseInt(gammaBinary, 2, 64)

  return fmt.Sprintf("%v", epsilon * gamma)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 3, cache)
  input := aoc_utils.InputToSlice(content)

  oxygenBinaryInputs := input
  co2BinaryInputs := input
  for i, _ := range strings.Split(input[0], "") {
    oxygenBinaryInputs = Part2Filter(oxygenBinaryInputs, true, i, "1")
  }
  for i, _ := range strings.Split(input[0], "") {
    co2BinaryInputs = Part2Filter(co2BinaryInputs, false, i, "0")
  }

  oxygen, _ := strconv.ParseInt(oxygenBinaryInputs[0], 2, 64)
  co2, _ := strconv.ParseInt(co2BinaryInputs[0], 2, 64)

  return fmt.Sprintf("%v", oxygen * co2)
}

func Part2Filter(input []string, takeMore bool, charIndex int, tieChar string) []string {
  if len(input) == 1 {
    return input
  }
  resultIfZero := []string{}
  resultIfOne := []string{}
  for _, val := range input {
    if strings.Split(val, "")[charIndex] == "0" {
      resultIfZero = append(resultIfZero, val)
    } else {
      resultIfOne = append(resultIfOne, val)
    }
  }

  lenZero := len(resultIfZero)
  lenOne := len(resultIfOne)
  if lenZero == lenOne {
    if tieChar == "0" {
      return resultIfZero
    } else {
      return resultIfOne
    }
  } else if takeMore {
    if lenZero > lenOne {
      return resultIfZero
    } else {
      return resultIfOne
    }
  } else {
    if lenZero > lenOne {
      return resultIfOne
    } else {
      return resultIfZero
    }
  }
}


