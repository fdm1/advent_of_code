package y21d15

import (
  "fmt"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)

func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 15, cache)
  grid := aoc_utils.InputToSliceOfIntSlices(content)
  distances := map[string]int{}
  nodesToCheck := []string{}
  for x := 0; x < len(grid); x++ {
    for y := 0; y < len(grid[0]); y++ {
      node := aoc_utils.GridIntsToPoint(x,y)
      if x == 0 && y == 0 {
        distances[node] = 0
      } else {
        distances[node] = aoc_utils.Infinity()
      }
    }
  }
  currentNode := aoc_utils.GridIntsToPoint(0, 0)
  targetNode := aoc_utils.GridIntsToPoint(len(grid) - 1, len(grid[0]) - 1)
  running := true

  for running {
    distances, nodesToCheck, currentNode = MoveDijkstra(
      grid, distances, nodesToCheck, currentNode, targetNode)
    running = currentNode != targetNode
  }
  return fmt.Sprintf("%v", distances[targetNode])
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 15, cache)
  grid := aoc_utils.InputToSliceOfIntSlices(content)
  initialRows := len(grid)
  initialColumns := len(grid[0])
  grid = ExpandGrid(grid, initialRows, initialColumns)
  grid = ExpandGrid(grid, initialRows, initialColumns)
  grid = ExpandGrid(grid, initialRows, initialColumns)
  grid = ExpandGrid(grid, initialRows, initialColumns)

  distances := map[string]int{}
  for x := 0; x < len(grid); x++ {
    for y := 0; y < len(grid[0]); y++ {
      node := aoc_utils.GridIntsToPoint(x,y)
      if x == 0 && y == 0 {
        distances[node] = 0
      } else {
        distances[node] = aoc_utils.Infinity()
      }
    }
  }
  nodesToCheck := []string{}
  currentNode := aoc_utils.GridIntsToPoint(0, 0)
  targetNode := aoc_utils.GridIntsToPoint(len(grid) - 1, len(grid[0]) - 1)
  running := true

  for running {
    distances, nodesToCheck, currentNode = MoveDijkstra(
      grid, distances, nodesToCheck, currentNode, targetNode)
    running = currentNode != targetNode
  }
  return fmt.Sprintf("%v", distances[targetNode])
}

func MoveDijkstra(grid [][]int, distances map[string]int, nodesToCheck []string, currentNode string, targetNode string) (map[string]int, []string, string) {
  newDistances := distances
  currentX, currentY := aoc_utils.GridPointToInts(currentNode)
  neighbors := []string{}
  newNodesToCheck := []string{}

  if currentX < len(grid[0]) - 1 { neighbors = append(neighbors, aoc_utils.GridIntsToPoint(currentX+1, currentY)) }
  if currentY < len(grid) - 1 { neighbors = append(neighbors, aoc_utils.GridIntsToPoint(currentX, currentY+1)) }
  if currentY > 0 { neighbors = append(neighbors, aoc_utils.GridIntsToPoint(currentX, currentY-1)) }
  if currentX > 0 { neighbors = append(neighbors, aoc_utils.GridIntsToPoint(currentX-1, currentY)) }

  currentNodeDistance := distances[currentNode]

  for _, node := range neighbors {
    neighborX, neighborY := aoc_utils.GridPointToInts(node)
    potentialNewDistance := grid[neighborX][neighborY] + currentNodeDistance
    if potentialNewDistance < distances[node] {
      newDistances[node] = potentialNewDistance
      newNodesToCheck = append(newNodesToCheck, node)
    }
  }
  for _, node := range nodesToCheck {
    if node != currentNode {
      newNodesToCheck = append(newNodesToCheck, node)
    }
  }

  newCurrentNode := currentNode
  smallestNewDistance := aoc_utils.Infinity()
  for _, node := range nodesToCheck {
    if newDistances[node] < smallestNewDistance {
      smallestNewDistance = newDistances[node]
      newCurrentNode = node
    }
  }

  return newDistances, newNodesToCheck, newCurrentNode
}

func ExpandGrid(grid [][]int, rows int, columns int) [][]int {
  newGrid := [][]int{}
  for row, rowVals := range grid {
    newRow := grid[row]
    for c := 0; c < columns; c++ {
      oldVal := rowVals[len(rowVals) - (columns - c)]
      if oldVal == 9 {
        newRow = append(newRow, 1)
      } else {
        newRow = append(newRow, oldVal + 1)
      }
    }
    newGrid = append(newGrid, newRow)
  }
  for r := 0; r < rows; r++ {
    newRow := []int{}
    for _, val := range newGrid[len(newGrid) - rows] { newRow = append(newRow, val) }
    for i, val := range newRow {
      if val == 9 {
        newRow[i] = 1
      } else {
        newRow[i] = val + 1
      }
    }
    newGrid = append(newGrid, newRow)
  }

  return newGrid
}
