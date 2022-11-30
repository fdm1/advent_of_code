package y21d10

import (
  "fmt"
  "sort"
  "strings"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 10, cache)
  input := aoc_utils.InputToSlice(content)
  score := 0
  for _, line := range input {
    char, _ := FindIllegalChar(line)
    charScore := ScoreForChar(char)
    score += charScore
  }
  return fmt.Sprintf("%v", score)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 10, cache)
  input := aoc_utils.InputToSlice(content)
  scores := []int{}
  for _, line := range input {
    illegalChar, lastOpen := FindIllegalChar(line)
    if illegalChar == "" {
      scores = append(scores, ScoreForAutocomplete(lastOpen))
    }
  }
  sort.Ints(scores)

  return fmt.Sprintf("%v", scores[len(scores)/2])
}

func ScoreForChar(char string) int {
  if char == ")" { return 3 }
  if char == "]" { return 57 }
  if char == "}" { return 1197 }
  if char == ">" { return 25137 }
  return 0
}

func ScoreForAutocomplete(lastOpen []string) int {
  score := 0
  for i := len(lastOpen) - 1; i >= 0; i-- {
    char := lastOpen[i]
    score *= 5
    if char == "(" { score += 1 }
    if char == "[" { score += 2 }
    if char == "{" { score += 3 }
    if char == "<" { score += 4 }
  }
  return score
}


func CharIsOpen(char string) bool {
  return char == "(" || char == "[" || char == "{" || char == "<"
}

func CharClosingMatcher(char string) string {
  charMap := map[string]string{}
  charMap[")"] = "("
  charMap["]"] = "["
  charMap["}"] = "{"
  charMap[">"] = "<"
  return charMap[char]
}


func FindIllegalChar(line string) (string, []string) {
  chars := strings.Split(line, "")
  lastOpen := []string{}
  for _, char := range chars {
    if CharIsOpen(char) {
      lastOpen = append(lastOpen, char)
    } else {
      if lastOpen[len(lastOpen) - 1] == CharClosingMatcher(char) {
        lastOpen = lastOpen[0:len(lastOpen) - 1]
      } else {
        return char, lastOpen
      }
    }
  }
  return "", lastOpen
}

