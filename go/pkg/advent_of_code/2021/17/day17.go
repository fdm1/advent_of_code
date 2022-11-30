package y2021d17

import (
  "fmt"
  "strings"
  "strconv"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 17, cache)
  input := aoc_utils.InputToSlice(content)
  xRange, yRange := ParseInput(input[0])

  maxY := 0
  currentMaxY := 0
  x := 0
  for true {
    maxYForX := 0
    currentYForX := 0
    y := 0
    for true {
      currentMaxY := MaxYForVelocity(x, y, xRange, yRange)
      if currentMaxY > maxY {
        maxY = currentMaxY
      }
      if currentYForX < maxYForX {
        break
      }
      if y > 500 { break }
      y++
    }
    if currentMaxY < maxY { break }
    x++
  }

  return fmt.Sprintf("%v", maxY)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 17, cache)
  input := aoc_utils.InputToSlice(content)
  xRange, yRange := ParseInput(input[0])

  count := 0
  x := 0
  for true {
    y := -1000
    for true {
      if MaxYForVelocity(x, y, xRange, yRange) > -aoc_utils.Infinity() { count++ }
      if y > 3000 { break }
      y++
    }
    if x > 5000 { break }
    x++
  }

  return fmt.Sprintf("%v", count)
}

func MaxYForVelocity(xVel int, yVel int, xGoalRange []int, yGoalRange []int) int {
  xPosition := 0
  yPosition := 0
  maxY := -1000
  newXVel := xVel
  newYVel := yVel

  for !InEndZone(xPosition, yPosition, xGoalRange, yGoalRange) {
    xPosition, yPosition, newXVel, newYVel = Move(xPosition, yPosition, newXVel, newYVel)
    if yPosition > maxY { maxY = yPosition }

    if InEndZone(xPosition, yPosition, xGoalRange, yGoalRange) {
      break
    }
    if PastEndZone(xPosition, yPosition, xGoalRange, yGoalRange) {
      return -aoc_utils.Infinity()
    }
  }

  return maxY
}

func Move(xPos int, yPos int, xVel int, yVel int) (int, int, int, int) {
  newXPos := xPos + xVel
  newYPos := yPos + yVel
  newXVel := xVel
  newYVel := yVel
  if newXVel != 0 {
    if newXVel > 0 { newXVel-- } else { newXVel++ }
  }
  newYVel--
  return newXPos, newYPos, newXVel, newYVel
}

func InEndZone(xPos int, yPos int, xRange []int, yRange []int) bool {
  return xPos >= xRange[0] && xPos <= xRange[1] && yPos >= yRange[0] && yPos <= yRange[1]
}

func PastEndZone(xPos int, yPos int, xRange []int, yRange []int) bool {
  return xPos > xRange[1] || yPos < yRange[0]
}

func ParseInput(input string) ([]int, []int) {
  halves := strings.Split(input, ", ")
  xPortion := strings.Split(halves[0], ": x=")[1]
  xRangeStrings := strings.Split(xPortion, "..")
  yPortion := strings.Split(halves[1], "=")[1]
  yRangeStrings := strings.Split(yPortion, "..")

  xRange := []int{}
  yRange := []int{}

  for _, val := range xRangeStrings {
    intVal, _ := strconv.Atoi(val)
    xRange = append(xRange, intVal)
  }
  for _, val := range yRangeStrings {
    intVal, _ := strconv.Atoi(val)
    yRange = append(yRange, intVal)
  }

  return xRange, yRange
}

