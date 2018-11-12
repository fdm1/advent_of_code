# 2015 - Day 1: http://adventofcode.com/2015/day/1

defmodule ElixirAdvent.Year2015.Day01 do
  def part1(input) do
    reduce_parens(ElixirAdvent.read_input(input), 0)
  end

  def part2(input) do
    ElixirAdvent.read_input(input)
  end

  def reduce_parens(input, val) do
    {head, tail} = String.split_at(input, 1)
    case head do
      "(" -> reduce_parens(tail, val + 1)
      ")" -> reduce_parens(tail, val - 1)
      "" -> val
    end
  end
end