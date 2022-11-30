package main

import (
  "fmt"
  "sort"
  "strings"
  "strconv"
  "time"

  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func main() {
  yearNeeded := true
  validYears := ValidYears()
  sort.Strings(validYears)
  year := ""
  for yearNeeded {
    fmt.Printf("Year: ")
    fmt.Scanln(&year)
    if aoc_utils.StringSliceContainsString(validYears, year) {
      yearNeeded = false
    } else {
      validYearInts := []int{}
      for _, y := range validYears {
        yearInt, _ := strconv.Atoi(y)
        validYearInts = append(validYearInts, yearInt)
      }
      sort.Ints(validYearInts)
      fmt.Printf("Year %v is not valid. Valid choices are %v\n\n", year, validYearInts)
    }
  }

  dayNeeded := true
  validDays := ValidDays(year)
  day := ""
  for dayNeeded {
    fmt.Printf("Day: ")
    fmt.Scanln(&day)
    if aoc_utils.StringSliceContainsString(validDays, day) {
      dayNeeded = false
    } else {
      validDayInts := []int{}
      for _, d := range validDays {
        dayInt, _ := strconv.Atoi(d)
        validDayInts = append(validDayInts, dayInt)
      }
      sort.Ints(validDayInts)
      fmt.Printf("Day %v is not valid. Valid choices are %v\n\n", day, validDayInts)
    }
  }

  partNeeded := true
  part := ""
  validParts := []string{"1", "2"}
  for partNeeded {
    fmt.Printf("Part: ")
    fmt.Scanln(&part)
    if aoc_utils.StringSliceContainsString(validParts, part) {
      partNeeded = false
    } else {
      fmt.Printf("Part %v is not valid. Valid choices are %v\n\n", part, validParts)
    }
  }

  function := advent_of_code.PuzzleMap(year, day, part)
  start := time.Now()
  result := function(true)
  duration := time.Since(start)
  fmt.Printf("Result: %v\n", result)
  fmt.Printf("Ran in %v\n", duration)
}

func ValidYears() []string {
  resultMap := map[string]bool{}
  for key, _ := range advent_of_code.PuzzleFunctions() {
    resultMap[strings.Split(key, "-")[0]] = true
  }
  result := []string{}
  for key, _ := range resultMap {
    result = append(result, key)
  }
  return result
}

func ValidDays(year string) []string {
  resultMap := map[string]bool{}
  for key, _ := range advent_of_code.PuzzleFunctions() {
    if year == strings.Split(key, "-")[0] {
      resultMap[strings.Split(key, "-")[1]] = true
    }
  }
  result := []string{}
  for key, _ := range resultMap {
    result = append(result, key)
  }
  return result
}
