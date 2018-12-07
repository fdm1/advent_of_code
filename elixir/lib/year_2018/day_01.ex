# 2018 - Day 01: http://adventofcode.com/2018/day/1

defmodule ElixirAdvent.Year2018.Day01 do
  def part1(input) do
    freq = input_to_int_list(ElixirAdvent.read_input(input))
    Enum.reduce(freq, 0, fn i, acc -> acc + i end)
  end

  def part2(input) do
    freq = input_to_int_list(ElixirAdvent.read_input(input))
    reduce_part2(freq, 0, MapSet.new([0]), false)
  end

  def reduce_part2(freq, new_val, seen_vals, found) do
    res = Enum.reduce_while(freq, [new_val, seen_vals, found], fn i, acc ->
      new_val = Enum.at(acc, 0) + i
      seen_vals = Enum.at(acc, 1)
      if Enum.at(acc, 2),
         do: {:halt, acc},
         else: {:cont, [new_val, MapSet.put(seen_vals, new_val), MapSet.member?(seen_vals, new_val)]}
    end)

    if Enum.at(res, 2) do
      Enum.at(res, 0)
    else
      reduce_part2(freq, Enum.at(res, 0), Enum.at(res, 1), Enum.at(res, 2))
    end
  end

  def input_to_int_list(input) do
    Enum.map(
      String.split(input, "\n", trim: true), fn(i) ->
        String.to_integer(i)
      end
    )
  end
end
