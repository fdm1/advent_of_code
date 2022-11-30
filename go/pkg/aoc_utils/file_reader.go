package aoc_utils

import (
  "fmt"
  "os"
)

func ReadFile(filename string) string {
  content, err := os.ReadFile(filename)

  if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading input body: %s\n", err)
		os.Exit(3)
  }
  return string(content)
}
