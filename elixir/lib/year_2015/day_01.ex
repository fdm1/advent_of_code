# 2015 - Day 1: http://adventofcode.com/2015/day/1

defmodule ElixirAdvent.Year2015.Day01 do
  def part1(input) do
    reduce_parens(ElixirAdvent.read_input(input))
  end

  def part2(input) do
    reduce_parens(ElixirAdvent.read_input(input), true)
  end

  def reduce_parens(input, val, step, stop_at_basement) do
    {head, tail} = String.split_at(input, 1)
    if stop_at_basement and (val < 0 or head == "") do
      step 
    else
      case head do
        "(" -> reduce_parens(tail, val + 1, step + 1, stop_at_basement)
        ")" -> reduce_parens(tail, val - 1, step + 1, stop_at_basement)
        "" -> val
      end
    end
  end

  def reduce_parens(input) do
    reduce_parens(input, 0, 0)
  end

  def reduce_parens(input, stop_at_basement) when is_boolean(stop_at_basement) do
    reduce_parens(input, 0, 0, stop_at_basement)
  end

  def reduce_parens(input, val, step) do
    reduce_parens(input, val, step, false)
  end


end