package aoc_utils

func IntSliceMinMax(intSlice []int) []int {
  minMax := make([]int, 2)
  for _, val := range intSlice {
    if val < minMax[0] {
      minMax[0] = val
    }
    if val > minMax[1] {
      minMax[1] = val
    }
  }
  return minMax
}
