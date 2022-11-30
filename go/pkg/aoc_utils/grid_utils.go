package aoc_utils

import (
  "fmt"
  "strings"
  "strconv"
)

func GridPointToInts(point string) (int, int) {
  pointStrings := strings.Split(point, ",")
  x, _ := strconv.Atoi(pointStrings[0])
  y, _ := strconv.Atoi(pointStrings[1])
  return x, y
}

func GridIntsToPoint(x int, y int) string {
  return fmt.Sprintf("%v,%v", x, y)
}

func Infinity() int {
  return 9999999999999999
}
