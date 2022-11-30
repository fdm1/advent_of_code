package y21d11

import (
  "fmt"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 11, cache)
  intRows := aoc_utils.InputToSliceOfIntSlices(content)
  flashes := 0
  for i := 0; i < 100; i++ {
    var newFlashes int
    intRows, newFlashes = Iterate(intRows)
    flashes += newFlashes
  }
  return fmt.Sprintf("%v", flashes)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 11, cache)
  intRows := aoc_utils.InputToSliceOfIntSlices(content)
  iterations := 0
  notAllZero := !AllZero(intRows)

  for notAllZero {
    intRows, _ = Iterate(intRows)
    iterations += 1
    notAllZero = !AllZero(intRows)
  }

  return fmt.Sprintf("%v", iterations)
}

func AllZero(intRows [][]int) bool {
  for row, _ := range intRows {
    for column := 0; column < len(intRows[0]); column ++ {
      if intRows[row][column] > 0 { return false }
    }
  }

  return true
}
func Iterate(intRows [][]int) ([][]int, int) {
  for row, _ := range intRows {
    for column := 0; column < len(intRows[0]); column ++ {
      intRows[row][column] += 1
    }
  }

  var flashes int
  for row, _ := range intRows {
    for column := 0; column < len(intRows[0]); column ++ {
      var newFlashes int
      intRows, newFlashes = Flash(row, column, intRows)
      flashes += newFlashes
    }
  }

  return intRows, flashes
}

func Flash(x int, y int, intRows [][]int) ([][]int, int) {
  if intRows[x][y] < 10 { return intRows, 0 }
  xPointsPossible := []int{x - 1, x, x + 1}
  yPointsPossible := []int{y - 1, y, y + 1}
  xPoints := []int{}
  yPoints := []int{}
  totalFlashes := 1
  intRows[x][y] = 0
  for _, point := range xPointsPossible {
    if point >= 0 && point < len(intRows[0]) { xPoints = append(xPoints, point) }
  }
  for _, point := range yPointsPossible {
    if point >= 0 && point < len(intRows) { yPoints = append(yPoints, point) }
  }

  for _, xPoint := range xPoints {
    for _, yPoint := range yPoints {
      if intRows[xPoint][yPoint] != 0 {
        intRows[xPoint][yPoint] += 1
      }
    }
  }
  for _, xPoint := range xPoints {
    for _, yPoint := range yPoints {
      if intRows[xPoint][yPoint] > 9 {
        var newFlashes int
        intRows, newFlashes = Flash(xPoint, yPoint, intRows)
        totalFlashes += newFlashes
      }
    }
  }

  return intRows, totalFlashes
}

