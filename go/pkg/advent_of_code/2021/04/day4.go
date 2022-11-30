package y21d4

import (
  "fmt"
  "strings"
  "strconv"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 4, cache)
  input := aoc_utils.InputToSlice(content)
  numbers := strings.Split(input[0], ",")
  boards := [][][]string{}
  boardStartRows := []int{}
  for i, val := range input {
    if val == "" {
      boardStartRows = append(boardStartRows, i+1)
    }
  }
  for _, startRow := range boardStartRows {
    endRow := startRow + len(aoc_utils.DeleteEmptyFromStringSlice(strings.Split(input[startRow], " "))) + 1
    boards = append(boards, ExtractBingoBoard(input[startRow:endRow]))
  }

  calledNumbers := []string{}
  result := 0
  for _, val := range numbers {
    calledNumbers = append(calledNumbers, val)
    winningBoards := CheckForWinningBoard(boards, calledNumbers)
    if len(winningBoards) > 0 {
      lastCalledNum, _ := strconv.Atoi(calledNumbers[len(calledNumbers) - 1])

      for _, winningBoard := range winningBoards {
        numberMap := AllBoardNumbersMap(winningBoard)
        unmarkedNumbers := GetUnmarkedNumberStrings(numberMap, calledNumbers)
        sum := 0
        for _, val := range unmarkedNumbers {
          numVal, _ := strconv.Atoi(val)
          sum += numVal
        }
        if sum * lastCalledNum > result {
          result = sum * lastCalledNum
        }
      }

      return fmt.Sprintf("%v", result)
    }
  }

  return fmt.Sprintf("diddly squat")
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 4, cache)
  input := aoc_utils.InputToSlice(content)
  numbers := strings.Split(input[0], ",")
  boards := [][][]string{}
  boardStartRows := []int{}
  for i, val := range input {
    if val == "" {
      boardStartRows = append(boardStartRows, i+1)
    }
  }
  for _, startRow := range boardStartRows {
    endRow := startRow + len(aoc_utils.DeleteEmptyFromStringSlice(strings.Split(input[startRow], " "))) + 1
    boards = append(boards, ExtractBingoBoard(input[startRow:endRow]))
  }

  calledNumbers := []string{}
  scores := []int{}
  winningBoardStrings := []string{}
  for _, val := range numbers {
    calledNumbers = append(calledNumbers, val)
    winningBoards := CheckForWinningBoard(boards, calledNumbers)
    if len(winningBoards) > 0 {
      lastCalledNum, _ := strconv.Atoi(calledNumbers[len(calledNumbers) - 1])

      for _, winningBoard := range winningBoards {
        boardWonBefore := false
        for _, boardString := range winningBoardStrings {
          if fmt.Sprintf("%v", winningBoard) == boardString {
            boardWonBefore = true
          }
        }
        if !boardWonBefore {
          winningBoardStrings = append(winningBoardStrings, fmt.Sprintf("%v", winningBoard))
          numberMap := AllBoardNumbersMap(winningBoard)
          unmarkedNumbers := GetUnmarkedNumberStrings(numberMap, calledNumbers)
          sum := 0
          for _, val := range unmarkedNumbers {
            numVal, _ := strconv.Atoi(val)
            sum += numVal
          }
          scores = append(scores, sum * lastCalledNum)
        }
      }
    }
  }

  return fmt.Sprintf("%v", scores[len(scores) - 1])
}

func ExtractBingoBoard(input []string) [][]string {
  result := [][]string{}
  rows := make([][]string, len(input))
  columns := make([][]string, len(input))
  for i:= 0; i < len(input); i++ {
    rows[i] = make([]string, len(input))
    columns[i] = make([]string, len(input))
  }

  for i, row := range input {
    rowVals := aoc_utils.DeleteEmptyFromStringSlice(strings.Split(row, " "))
    rows[i] = rowVals
    for c, rowVal := range rowVals {
      columns[c][i] = rowVal
    }
  }
  for _, val := range rows {
    if len(val) > 0 && val[0] != "" {
      result = append(result, val[0:len(input) - 1])
    }
  }
  for _, val := range columns {
    if len(val) > 0 && val[0] != "" {
      result = append(result, val[0:len(input) - 1])
    }
  }
  return result
}

func CheckForWinningBoard(boards [][][]string, numbers []string) [][][]string {
  winningBoards := [][][]string{}
  for _, board := range boards {
    for _, row := range board {
      if aoc_utils.StringSliceContainsAll(numbers, row) {
        winningBoards = append(winningBoards, board)
      }
    }
  }
  return winningBoards
}

func AllBoardNumbersMap(board [][]string) map[string]bool {
  keys := make(map[string]bool)
  for _, row := range board {
    for _, rowNumber := range row {
      if _, value := keys[rowNumber]; !value {
        keys[rowNumber] = true
      }
    }
  }

  return keys
}

func GetUnmarkedNumberStrings(boardNumbersMap map[string]bool, numbers []string) []string {
  result := []string{}
  calledNumbersMap := make(map[string]bool)
  for _, number := range numbers {
    calledNumbersMap[number] = true
  }

  for boardNumber, _ := range boardNumbersMap {
    if !calledNumbersMap[boardNumber] {
      result = append(result, boardNumber)
    }
  }

  return result
}

