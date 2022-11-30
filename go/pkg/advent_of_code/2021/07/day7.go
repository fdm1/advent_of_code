package y21d7

import (
  "fmt"
  "strings"
  "github.com/fdm1/advent_of_code_go/pkg/aoc_utils"
)


func Part1(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 7, cache)
  positions := aoc_utils.StringSliceToIntSlice(strings.Split(aoc_utils.InputToSlice(content)[0], ","))
  fuelCosts := make(map[int]int)
  minFuel := -1
  minMax := aoc_utils.IntSliceMinMax(positions)
  for moveTo := minMax[0]; moveTo <= minMax[1]; moveTo++ {
    if !(fuelCosts[moveTo] > 0) {
      fuelForPosition := 0
      for _, moveFrom := range positions {
        fuelForPosition += FuelCalculatorForPositions(moveTo, moveFrom, P1FuelCalculator)
      }
      fuelCosts[moveTo] = fuelForPosition
    }

    if minFuel == -1 {
      minFuel = fuelCosts[moveTo]
    } else if fuelCosts[moveTo] < minFuel {
      minFuel = fuelCosts[moveTo]
    }
  }

  return fmt.Sprintf("%v", minFuel)
}

func Part2(cache bool) string {
  content := aoc_utils.DownloadInput(2021, 7, cache)
  positions := aoc_utils.StringSliceToIntSlice(strings.Split(aoc_utils.InputToSlice(content)[0], ","))
  fuelCosts := make(map[int]int)
  minFuel := -1
  minMax := aoc_utils.IntSliceMinMax(positions)
  for moveTo := minMax[0]; moveTo <= minMax[1]; moveTo++ {
    if !(fuelCosts[moveTo] > 0) {
      fuelForPosition := 0
      for _, moveFrom := range positions {
        fuelForPosition += FuelCalculatorForPositions(moveTo, moveFrom, P2FuelCalculator)
      }
      fuelCosts[moveTo] = fuelForPosition
    }

    if minFuel == -1 {
      minFuel = fuelCosts[moveTo]
    } else if fuelCosts[moveTo] < minFuel {
      minFuel = fuelCosts[moveTo]
    }
  }

  return fmt.Sprintf("%v", minFuel)
}

func FuelCalculatorForPositions(moveTo int, moveFrom int, calculatorFunction func(int)int) int {
  if moveFrom >= moveTo {
    return calculatorFunction(moveFrom - moveTo)
  } else {
    return calculatorFunction(moveTo - moveFrom)
  }
}

func P1FuelCalculator(distance int) int {
  return distance
}


func P2FuelCalculator(distance int) int {
  fuel := 0
  for i := 0; i <= distance; i++ {
    fuel += i
  }
  return fuel
}

