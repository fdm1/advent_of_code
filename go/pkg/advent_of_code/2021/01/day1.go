package y21d1

import (
  "strconv"

  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 1, cache)
  inputInts := aoc_utils.InputToIntSlice(content)
  result := 0
  for i, val := range inputInts {
    if i > 0 && val > inputInts[i-1] {
      result += 1
    }
  }

  return strconv.Itoa(result)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 1, cache)
  inputInts := aoc_utils.InputToIntSlice(content)
  result := 0
  for i, _ := range inputInts {
    if i > 2 {
      currentSum := inputInts[i] + inputInts[i-1] + inputInts[i-2]
      lastSum := inputInts[i-1] + inputInts[i-2] + inputInts[i-3]
      if currentSum > lastSum {
        result += 1
      }
    }
  }

  return strconv.Itoa(result)
}
