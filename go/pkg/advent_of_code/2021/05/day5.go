package y21d5

import (
  "fmt"
  "strings"
  "strconv"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 5, cache)
  input := aoc_utils.InputToSlice(content)
  coordinateLines := [][]int{}
  for _, row := range input {
    coordinates := ExtractEndpoints(row)
    coordinateLines = append(coordinateLines, coordinates)
  }

  knownPoints := make(map[string]int)
  for _, endpoints := range coordinateLines {
    knownPoints = TallyLinePoints(knownPoints, endpoints, false)
  }

  pointsGte2 := 0
  for _, count := range knownPoints {
    if count >= 2 {
      pointsGte2 += 1
    }
  }

  return fmt.Sprintf("%v", pointsGte2)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 5, cache)
  input := aoc_utils.InputToSlice(content)
  coordinateLines := [][]int{}
  for _, row := range input {
    coordinates := ExtractEndpoints(row)
    coordinateLines = append(coordinateLines, coordinates)
  }

  knownPoints := make(map[string]int)
  for _, endpoints := range coordinateLines {
    knownPoints = TallyLinePoints(knownPoints, endpoints, true)
  }

  pointsGte2 := 0
  for _, count := range knownPoints {
    if count >= 2 {
      pointsGte2 += 1
    }
  }

  return fmt.Sprintf("%v", pointsGte2)
}

func ExtractEndpoints(line string) []int {
  result := []int{}
  points := strings.Split(line, " -> ")
  pointA := strings.Split(points[0], ",")
  pointB := strings.Split(points[1], ",")

  xA, _ := strconv.Atoi(pointA[0])
  yA, _ := strconv.Atoi(pointA[1])
  xB, _ := strconv.Atoi(pointB[0])
  yB, _ := strconv.Atoi(pointB[1])
  result = append(result, xA, yA, xB, yB)

  return result
}

func LinePoints(endpoints []int, includeDiagonal bool) []string {
  result := []string{}
  min := 0
  max := 0

  if endpoints[0] == endpoints[2] {
    if endpoints[1] < endpoints[3] {
      min = endpoints[1]
      max = endpoints[3]
    } else {
      min = endpoints[3]
      max = endpoints[1]
    }
    for i := min; i <= max; i++ {
      point := fmt.Sprintf("%v-%v", endpoints[0], i)
      result = append(result, point)
    }
  } else if endpoints[1] == endpoints[3] {
    if endpoints[0] < endpoints[2] {
      min = endpoints[0]
      max = endpoints[2]
    } else {
      min = endpoints[2]
      max = endpoints[0]
    }
    for i := min; i <= max; i++ {
      point := fmt.Sprintf("%v-%v", i, endpoints[1])
      result = append(result, point)
    }
  } else if includeDiagonal {
    minX := 0
    maxX := 0
    minY := 0
    maxY := 0
    if endpoints[0] < endpoints[2] {
      minX = endpoints[0]
      maxX = endpoints[2]
    } else {
      minX = endpoints[2]
      maxX = endpoints[0]
    }
    if endpoints[1] < endpoints[3] {
      minY = endpoints[1]
      maxY = endpoints[3]
    } else {
      minY = endpoints[3]
      maxY = endpoints[1]
    }

    if maxX-minX == maxY-minY {
      addtoY := 0
      point := ""
      if endpoints[0] > endpoints[2] {
        for i := endpoints[2]; i <= endpoints[0]; i++ {
          point = fmt.Sprintf("%v-%v", i, endpoints[3] + addtoY)
          if endpoints[1] > endpoints[3] {
            addtoY += 1
          } else {
            addtoY -= 1
          }
          result = append(result, point)
        }
      } else {
        for i := endpoints[0]; i <= endpoints[2]; i++ {
          point = fmt.Sprintf("%v-%v", i, endpoints[1] + addtoY)
          if endpoints[1] > endpoints[3] {
            addtoY -= 1
          } else {
            addtoY += 1
          }
          result = append(result, point)
        }
      }
    }
  }
  return result
}

func TallyLinePoints(knownPoints map[string]int, endpoints []int, includeDiagonal bool) map[string]int {
  linePoints := LinePoints(endpoints, includeDiagonal)
  for _, point := range linePoints {
    if knownPoints[point] > 0 {
      knownPoints[point] += 1
    } else {
      knownPoints[point] = 1
    }
  }
  return knownPoints
}
