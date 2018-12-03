# 2018 - Day 01: http://adventofcode.com/2018/day/1

defmodule ElixirAdvent.Year2018.Day01 do
  def part1(input) do
    freq = input_to_int_list(ElixirAdvent.read_input(input))
    Enum.reduce(freq, 0, fn i, acc -> acc + i end)
  end

  def part2(input) do
    ElixirAdvent.read_input(input)
  end

  def input_to_int_list(input) do
    Enum.map(
      String.split(input, "\n", trim: true), fn(i) ->
        String.to_integer(i)
      end
    )
  end

end
