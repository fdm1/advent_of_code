package y20d2

import (
  "strconv"
  "strings"

  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2020, 2, cache)
  inputLines := aoc_utils.InputToSlice(content)
  result := 0
  if len(inputLines) > 0 {
    result = 0
  }

  for _, inputLine := range inputLines {
    minCount, maxCount, char, password := ParseInputLine(inputLine)
    pwLength := len(password)
    charCount := pwLength - len(strings.Replace(password, char, "", -1))
    if minCount <= charCount && charCount <= maxCount {
      result = result + 1
    }
  }
  if result == 0 {
    return "no answer"
  }
  return strconv.Itoa(result)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2020, 2, cache)
  inputLines := aoc_utils.InputToSlice(content)
  result := 0
  if len(inputLines) > 0 {
    result = 0
  }

  for _, inputLine := range inputLines {
    index1, index2, char, password := ParseInputLine(inputLine)
    index1 = index1 - 1
    index2 = index2 - 1
    if string(password[index1]) == char && string(password[index2]) != char {
      result = result + 1
    }
    if string(password[index1]) != char && string(password[index2]) == char {
      result = result + 1
    }
  }
  if result == 0 {
    return "no answer"
  }
  return strconv.Itoa(result)
}

func ParseInputLine(input string) (int, int, string, string) {
  spaceSplit := strings.Split(input, " ")

  counts := strings.Split(spaceSplit[0], "-")
  char := strings.Replace(spaceSplit[1], ":", "", 1)
  password := spaceSplit[2]

  minCount, _ := strconv.Atoi(counts[0])
  maxCount, _ := strconv.Atoi(counts[1])
  return minCount, maxCount, char, password
}
