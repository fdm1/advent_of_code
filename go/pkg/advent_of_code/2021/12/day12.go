package y21d12

import (
  "fmt"
  "strings"
  "sort"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 12, cache)
  input := aoc_utils.InputToSlice(content)
  pathSegments := [][]string{}
  for _, row := range input {
    pathSegments = append(pathSegments, strings.Split(row, "-"))
  }
  return fmt.Sprintf("%v", GetUniquePathCount(pathSegments))
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 12, cache)
  input := aoc_utils.InputToSlice(content)
  pathSegments := [][]string{}
  for _, row := range input {
    pathSegments = append(pathSegments, strings.Split(row, "-"))
  }
  return fmt.Sprintf("%v", GetUniquePathCountWithSmallRepeat(pathSegments))
}

func GetUniquePathCount(pathSegments [][]string) int {
  paths := []string{"start"}
  for true {
    paths = AddToPaths(paths, pathSegments, false)
    if AllPathsEnded(paths) {
      return len(paths)
    }
  }

  return len(paths)
}

func GetUniquePathCountWithSmallRepeat(pathSegments [][]string) int {
  paths := []string{"start"}
  for true {
    paths = AddToPaths(paths, pathSegments, true)
    if AllPathsEnded(paths) {
      sort.Strings(paths)
      return len(paths)
    }
  }

  return len(paths)
}


func AddToPaths(currentPaths []string, pathSegments [][]string, allowSmallRepeat bool) []string {
  newPaths := map[string]bool{}
  for _, path := range currentPaths {
    if strings.HasSuffix(path, ",end") {
      newPaths[path] = true
    } else {
      currentPathSegments := strings.Split(path, ",")
      currentSegment := currentPathSegments[len(currentPathSegments) - 1]
      for _, segmentPair := range pathSegments {
        newPath := path
        if aoc_utils.StringSliceContainsString(segmentPair, currentSegment) {
          for _, segment := range segmentPair {
            if CanAppendToPath(newPath, segment, allowSmallRepeat) {
              newPath += fmt.Sprintf(",%v", segment)
              newPaths[newPath] = true
            }
          }
        }
      }
    }
  }
  newPathsSlice := []string{}
  for path, _ := range newPaths { newPathsSlice = append(newPathsSlice, path) }
  return newPathsSlice
}

func CanAppendToPath(currentPath string, newSegment string, allowSmallRepeat bool) bool {
  currentSegments := strings.Split(currentPath, ",")
  lastSegment := currentSegments[len(currentSegments) - 1]
  if newSegment == "start" { return false }
  if lastSegment == "end" { return false }
  if newSegment == lastSegment { return false }
  if strings.ToLower(newSegment) == newSegment && aoc_utils.StringSliceContainsString(currentSegments, newSegment) {
    if !allowSmallRepeat {
      return false
    } else {
      smallCaveCounts := map[string]int{}
      for _, segment := range currentSegments {
        if strings.ToLower(segment) == segment {
          if smallCaveCounts[segment] == 1 { return false }
          smallCaveCounts[segment]++
        }
      }
    }
  }

  return true
}

func AllPathsEnded(paths []string) bool {
  for _, path := range paths {
    if !strings.HasSuffix(path, ",end") { return false }
  }
  return true
}

