package y21d9

import (
  "fmt"
  "strconv"
  "strings"
  "sort"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 9, cache)
  intRows := aoc_utils.InputToSliceOfIntSlices(content)
  lowPoints := FindAllLowPoints(intRows)
  return fmt.Sprintf("%v", CalculateRisk(lowPoints))
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 9, cache)
  intRows := aoc_utils.InputToSliceOfIntSlices(content)
  lowPoints := FindAllLowPoints(intRows)
  basinSizes := []int{}
  for point, _ := range lowPoints {
    basinSizes = append(basinSizes, CalculateBasinFromPoint(point, intRows))
  }
  sort.Sort(sort.Reverse(sort.IntSlice(basinSizes)))
  result := 1
  for _, size := range basinSizes[0:3] {
    result *= size
  }

  return fmt.Sprintf("%v", result)
}


func FindAllLowPoints(intRows [][]int) map[string]int {
  lowPoints := map[string]int {}
  for i, _ := range intRows {
    newLowPoints := FindLowPointsForRow(i, intRows)
    for point, val := range newLowPoints {
      lowPoints[point] = val
    }
  }
  return lowPoints
}

func FindLowPointsForRow(row int, intRows [][]int) map[string]int {
  points := map[string]int{}

  for i, val := range intRows[row] {
    if row > 0 {
      if intRows[row-1][i] <= val { continue }
    }
    if row < len(intRows) - 1 {
      if intRows[row+1][i] <= val { continue }
    }
    if i > 0 {
      if intRows[row][i-1] <= val { continue }
    }
    if i < len(intRows[0]) - 1 {
      if intRows[row][i+1] <= val { continue }
    }
    point := PointToString(row, i)
    points[point] = val
  }
  return points
}

func PointToString(x int, y int) string {
  return fmt.Sprintf("%v,%v", x, y)
}

func PointFromString(point string) (int, int) {
  xyStrings := strings.Split(point, ",")
  x, _ := strconv.Atoi(xyStrings[0])
  y, _ := strconv.Atoi(xyStrings[1])
  return x, y
}

func CalculateRisk(lowPoints map[string]int) int {
  risk := 0
  for _, val := range lowPoints {
    risk += val + 1
  }
  return risk
}

func GetBasinInRowFromPoint(point string, intRows [][]int) map[string]int {
  result := map[string]int{}
  x, y := PointFromString(point)
  if intRows[x][y] != 9 { result[point] = intRows[x][y] }
  row := intRows[x]
  if y < len(row) - 1 {
    for i := y+1; i <= len(row) - 1; i++ {
      if row[i] < row[i-1] || row[i] == 9 {
        break
      } else {
        result[PointToString(x, i)] = row[i]
      }
    }
  }
  if y > 0 {
    for i := y-1; i >= 0; i-- {
      if row[i] < row[i+1] || row[i] == 9 {
        break
      } else {
        result[PointToString(x, i)] = row[i]
      }
    }
  }
  return result
}

func PointAboveOrBelowIsPartOfBasin(point string, value int, otherRow []int) bool {
  _, y  := PointFromString(point)
  return otherRow[y] > value && otherRow[y] != 9
}

func AppendBasinPoints(points map[string]int, newPoints map[string]int) map[string]int {
  for newPoint, newValue := range newPoints {
    points[newPoint] = newValue
  }
  return points
}


func CalculateBasinFromPoint(point string, intRows [][]int) int {
  pointX, _ := PointFromString(point)
  points := map[string]int{}
  points = AppendBasinPoints(points, GetBasinInRowFromPoint(point, intRows))
  for i := pointX; i < len(intRows) - 1; i++ {
    for newPoint, val := range points {
      newPointX, newPointY := PointFromString(newPoint)
      if newPointX == i {
        if PointAboveOrBelowIsPartOfBasin(newPoint, val, intRows[newPointX+1]) {
          points = AppendBasinPoints(points, GetBasinInRowFromPoint(PointToString(newPointX+1, newPointY), intRows))
        }
      }
    }
  }
  for i := pointX; i > 0; i-- {
    for newPoint, val := range points {
      newPointX, newPointY := PointFromString(newPoint)
      if newPointX == i {
        if PointAboveOrBelowIsPartOfBasin(newPoint, val, intRows[newPointX-1]) {
          points = AppendBasinPoints(points, GetBasinInRowFromPoint(PointToString(newPointX-1, newPointY), intRows))
        }
      }
    }
  }

  return len(points)
}
