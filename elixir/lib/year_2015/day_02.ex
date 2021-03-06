# 2015 - Day 02: http://adventofcode.com/2015/day/2
defmodule ElixirAdvent.Year2015.Day02 do
  def part1(input) do
    Enum.sum(Enum.map(input_to_dim_list(input), fn(dim) -> paper_for_box(dim) end))
  end

  def part2(input) do
    Enum.sum(Enum.map(input_to_dim_list(input), fn(dim) -> ribbon_for_box(dim) end))
  end

  def input_to_dim_list(input) do
    dim_strings = String.split(input, "\n")
    Enum.map(dim_strings, fn(s) ->
      Enum.map(String.split(s, "x"), fn(i) ->
        String.to_integer(i)
      end)
    end)
  end

  def paper_for_box(dim) do
    sides = Enum.map(
      0..length(dim)-1,
      fn i -> Enum.at(dim, i) * Enum.at(dim, i-1) end
    )
    min_side = Enum.min(sides)

    Enum.sum(Enum.map(sides, fn(side) -> 2 * side end)) + min_side
  end

  def ribbon_for_box(dim) do
    small_edges = Enum.drop(Enum.sort(dim), -1)
    edges = Enum.reduce(small_edges, 0, fn i, acc -> acc + (2 * i) end)
    bow = Enum.reduce(dim, fn i, acc -> acc * i end)

    edges + bow
  end
end
