package y21d6

import (
  "fmt"
  "strings"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 6, cache)
  fishInts := aoc_utils.StringSliceToIntSlice(strings.Split(aoc_utils.InputToSlice(content)[0], ","))

  fishCounters := InitializeFish(fishInts)
  fishCounters = IterateFishNTimes(fishCounters, 80)
  return fmt.Sprintf("%v", CountFish(fishCounters))
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 6, cache)
  fishInts := aoc_utils.StringSliceToIntSlice(strings.Split(aoc_utils.InputToSlice(content)[0], ","))

  fishCounters := InitializeFish(fishInts)
  fishCounters = IterateFishNTimes(fishCounters, 256)
  return fmt.Sprintf("%v", CountFish(fishCounters))
}

func InitializeFish(inputInts []int) map[int]int {
  fishCounters := make(map[int]int)
  for _, val := range inputInts {
    fishCounters[val] += 1
  }
  return fishCounters
}

func CountFish(fishCounters map[int]int) int {
  result := 0
  for _, val := range fishCounters {
    result += val
  }
  return result
}

func IterateFishNTimes(fishCounters map[int]int, times int) map[int]int {
  for i := 0; i < times; i++ {
    fishCounters = IterateFishOnce(fishCounters)
  }
  return fishCounters
}


func IterateFishOnce(fishCounters map[int]int) map[int]int {
  newFishCounters := make(map[int]int)

  for num, count := range fishCounters {
    if num == 0 {
      newFishCounters[8] += count
      newFishCounters[6] += count
    } else {
      newFishCounters[num - 1] += count
    }
  }

  return newFishCounters
}
