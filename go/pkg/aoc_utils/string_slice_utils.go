package aoc_utils

import (
  "strconv"
)

func DeleteEmptyFromStringSlice(input []string) []string {
  result := []string{}
  for _, val := range input {
    if val != "" {
      result = append(result, val)
    }
  }
  return result
}

func StringSliceContainsAll(inputStrings []string, valuesToCheck[]string) bool {
  for _, valToCheck := range valuesToCheck {
    if !StringSliceContainsString(inputStrings, valToCheck) {
      return false
    }
  }
  return true
}

func StringSliceContainsString(stringSlice []string, valToCheck string) bool {
  for _, val := range stringSlice {
    if valToCheck == val {
      return true
    }
  }
  return false
}

func StringSliceToIntSlice(input []string) []int {
  result := []int{}
  for _, val := range input {
    newInt, _ := strconv.Atoi(val)
    result = append(result, newInt)
  }
  return result
}
