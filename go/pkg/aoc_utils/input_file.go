package aoc_utils

import "fmt"

func TestInput(name string) string {
  return fmt.Sprintf("../../../../test_inputs/%v.txt", name)
}

func InputFile(year string, day string) string {
  return fmt.Sprintf("puzzle_inputs/year_%v_day_%v.txt", year, day)
}
