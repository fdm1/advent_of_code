package y21d14

import (
  "fmt"
  "strings"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 14, cache)
  input := aoc_utils.InputToSlice(content)
  inputChars := strings.Split(input[0], "")
  segmentMap := map[string]int{}
  for i, _ := range inputChars[0:len(inputChars) - 1] {
    segmentMap[strings.Join(inputChars[i:i+2], "")] += 1
  }

  steps := [][]string{}
  for _, row := range input[2:len(input)] {
    steps = append(steps, strings.Split(row, " -> "))
  }

  for i := 0; i < 10; i++ {
    segmentMap = Iterate(segmentMap, steps)
  }

  return fmt.Sprintf("%v", CalculateScore(segmentMap, inputChars[0]))
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 14, cache)
  input := aoc_utils.InputToSlice(content)
  inputChars := strings.Split(input[0], "")
  segmentMap := map[string]int{}
  for i, _ := range inputChars[0:len(inputChars) - 1] {
    segmentMap[strings.Join(inputChars[i:i+2], "")] += 1
  }

  steps := [][]string{}
  for _, row := range input[2:len(input)] {
    steps = append(steps, strings.Split(row, " -> "))
  }

  for i := 0; i < 40; i++ {
    segmentMap = Iterate(segmentMap, steps)
  }

  return fmt.Sprintf("%v", CalculateScore(segmentMap, inputChars[0]))
}

func Iterate(charMap map[string]int, steps [][]string) map[string]int {
  newCharMap := map[string]int{}

  foundSegments := []string{}
  for _, step := range steps {
    if charMap[step[0]] > 0 {
      splitStep := strings.Split(step[0], "")
      newChars := []string{
        strings.Join([]string{splitStep[0], step[1]}, ""),
        strings.Join([]string{step[1], splitStep[1]}, ""),
      }
      for _, char := range newChars { newCharMap[char] += charMap[step[0]] }
      foundSegments = append(foundSegments, step[0])
    }
  }

  for segment, _ := range charMap {
    if !aoc_utils.StringSliceContainsString(foundSegments, segment) {
      newCharMap[segment] += charMap[segment]
    }
  }

  return newCharMap
}

func CalculateScore(segmentMap map[string]int, firstChar string) int {
  characterCounts := map[string]int{}
  for char, val := range segmentMap { characterCounts[strings.Split(char, "")[1]] += val}
  characterCounts[firstChar] += 1

  minCount := -1
  maxCount := -1
  for _, count := range characterCounts {
    if minCount == -1 {
      minCount = count
      maxCount = count
    } else {
      if count < minCount { minCount = count }
      if count > maxCount { maxCount = count }
    }
  }

  return maxCount - minCount
}
