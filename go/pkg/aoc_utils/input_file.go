package aoc_utils

import(
  "fmt"
  "strconv"
)

func TestInput(name string) string {
  return fmt.Sprintf("../../../../../test_input/%v.txt", name)
}

func InputFile(year string, day string) string {
  dayInt, _ := strconv.Atoi(day)
  return fmt.Sprintf("../inputs/%v/%02d.txt", year, dayInt)
}
