package y21d8

import (
  "fmt"
  "os"
  "strconv"
  "strings"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 8, cache)
  input := aoc_utils.InputToSlice(content)
  count := 0
  for _, row := range input {
    output := strings.Split(row, " | ")[1]
    for _, digit := range strings.Split(output, " ") {
      lenDigit := len(strings.Split(digit, ""))
      if lenDigit == 2 || lenDigit == 3 || lenDigit == 4 || lenDigit == 7 {
        count += 1
      }
    }
  }
  return fmt.Sprintf("%v", count)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 8, cache)
  input := aoc_utils.InputToSlice(content)
  res := 0
  for _, row := range input {
    rowVal :=  DecodeRow(row)
    if rowVal == -1 {
      fmt.Fprintf(os.Stderr, "Unable to decode row: %s\n", row)
      os.Exit(3)
    }
    res += rowVal
  }

  return fmt.Sprintf("%v", res)
}

func DecodeRow(row string) int {
  sides := strings.Split(row, " | ")
  input := sides[0]
  output := sides[1]
  digitMap := map[string]string{}

  // Try for an early return
  result, digitMap := DecodeOutput(output, digitMap)
  if result > 0 {
    return result
  }

  // Need to parse twice in case more complex decoding does not work on first pass
  for i := 0; i < 3; i++ {
    for _, digit := range strings.Split(input, " ") {
      decodedDigit := DecodeValue(digit, digitMap)
      if decodedDigit != "UNKNOWN" {
        digitMap[decodedDigit] = digit
        result, newDigitMap := DecodeOutput(output, digitMap)
        digitMap = newDigitMap
        if result > 0 {
          return result
        }
      }
    }
  }
  return -1
}

func DecodeOutput(output string, digitMap map[string]string) (int, map[string]string) {
  decodedVals := 0
  outputVal := ""
  newDigitMap := digitMap
  for _, digitChars := range strings.Split(output, " ") {
    digitVal := DecodeValue(digitChars, digitMap)
    if digitVal != "UNKNOWN" {
      newDigitMap[digitVal] = digitChars
      outputVal += digitVal
      decodedVals++
    }
    if decodedVals == 4 {
      res, _ := strconv.Atoi(outputVal)
      return res, newDigitMap
    }
  }
  return -1, newDigitMap
}

func DecodeValue(digit string, digitMap map[string]string) string {
  digitVals := strings.Split(digit, "")
  if len(digitVals) == 2 {
    return "1"
  } else if len(digitVals) == 3 {
    return "7"
  } else if len(digitVals) == 4 {
    return "4"
  } else if len(digitVals) == 7 {
    return "8"
  }

  if len(digitVals) == 5 {
    if len(digitMap["1"]) > 0 && len(digitMap["6"]) > 0 {
      if aoc_utils.StringSliceContainsAll(digitVals, strings.Split(digitMap["1"], "")) {
        return "3"
      } else {
        if aoc_utils.StringSliceContainsAll(strings.Split(digitMap["6"], ""), digitVals) {
          return "5"
        } else {
          return "2"
        }
      }
    }
  }

  if len(digitVals) == 6 {
    if len(digitMap["1"]) > 0  && len(digitMap["4"]) > 0 {
      if !aoc_utils.StringSliceContainsAll(digitVals, strings.Split(digitMap["1"], "")) {
        return "6"
      } else {
        if aoc_utils.StringSliceContainsAll(digitVals, strings.Split(digitMap["4"], "")) {
          return "9"
        } else {
          return "0"
        }
      }
    }
  }

  return "UNKNOWN"
}

