package aoc_utils

import (
  "strings"
  "strconv"
)

func InputToIntSlice(content string) []int {
  lines := InputToSlice(content)
  ints := make([]int, len(lines))
  for i, line := range lines {
    if line != "" {
      num, _ := strconv.Atoi(line)
      ints[i] = num
    }
  }
  return ints
}

func InputToSliceOfIntSlices(content string) [][]int {
  result := [][]int{}
  stringSlice := InputToSlice(content)
  for _, row := range stringSlice {
    stringSliceRow := strings.Split(row, "")
    intRow := []int{}
    for _, val := range stringSliceRow {
      intVal, _ := strconv.Atoi(val)
      intRow = append(intRow, intVal)
    }
    result = append(result, intRow)
  }
  return result
}

func InputToSlice(content string) []string {
  lines := strings.Split(string(content), "\n")
  return lines[0:len(lines)-1]
}
