package advent_of_code

import (
  "fmt"

  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2020/01"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2020/02"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/01"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/02"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/03"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/04"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/05"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/06"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/07"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/08"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/09"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/10"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/11"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/12"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/13"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/14"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/15"
  "github.com/fdm1/advent_of_code_go/pkg/advent_of_code/2021/17"
)

func PuzzleFunctions() map[string]func(bool) string {
  return map[string]func(bool) string {
    "2020-1-1": y20d1.Part1,
    "2020-1-2": y20d1.Part2,
    "2020-2-1": y20d2.Part1,
    "2020-2-2": y20d2.Part2,
    "2021-1-1": y21d1.Part1,
    "2021-1-2": y21d1.Part2,
    "2021-2-1": y21d2.Part1,
    "2021-2-2": y21d2.Part2,
    "2021-3-1": y21d3.Part1,
    "2021-3-2": y21d3.Part2,
    "2021-4-1": y21d4.Part1,
    "2021-4-2": y21d4.Part2,
    "2021-5-1": y21d5.Part1,
    "2021-5-2": y21d5.Part2,
    "2021-6-1": y21d6.Part1,
    "2021-6-2": y21d6.Part2,
    "2021-7-1": y21d7.Part1,
    "2021-7-2": y21d7.Part2,
    "2021-8-1": y21d8.Part1,
    "2021-8-2": y21d8.Part2,
    "2021-9-1": y21d9.Part1,
    "2021-9-2": y21d9.Part2,
    "2021-10-1": y21d10.Part1,
    "2021-10-2": y21d10.Part2,
    "2021-11-1": y21d11.Part1,
    "2021-11-2": y21d11.Part2,
    "2021-12-1": y21d12.Part1,
    "2021-12-2": y21d12.Part2,
    "2021-13-1": y21d13.Part1,
    "2021-13-2": y21d13.Part2,
    "2021-14-1": y21d14.Part1,
    "2021-14-2": y21d14.Part2,
    "2021-15-1": y21d15.Part1,
    "2021-15-2": y21d15.Part2,
    "2021-17-1": y2021d17.Part1,
    "2021-17-2": y2021d17.Part2,
  }
}

func PuzzleMap(year string, day string, part string) func(bool) string {
  return PuzzleFunctions()[fmt.Sprintf("%v-%v-%v", year, day, part)]
}
