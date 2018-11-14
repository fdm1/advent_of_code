# 2015 - Day 02: http://adventofcode.com/2015/day/2

defmodule ElixirAdvent.Year2015.Day02 do
  def part1(input) do
    dim_strings = String.split(ElixirAdvent.read_input(input), "\n")
    Enum.sum(Enum.map(dim_strings, fn(dim) -> paper_for_box(dim) end))
  end

  def part2(input) do
    ElixirAdvent.read_input(input)
  end

  def paper_for_box(dimension_string) do
    dim = Enum.map(String.split(dimension_string, "x"), fn(i) -> String.to_integer(i) end)
    sides = Enum.map(
      0..length(dim)-1,
      fn i -> Enum.at(dim, i) * Enum.at(dim, i-1) end
    )
    min_side = Enum.min(sides)

    Enum.sum(Enum.map(sides, fn(side) -> 2 * side end)) + min_side
  end
end
