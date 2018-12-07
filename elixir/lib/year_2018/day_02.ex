# 2018 - Day 02: http://adventofcode.com/2018/day/2

defmodule ElixirAdvent.Year2018.Day02 do
  def part1(input) do
    strings = String.split(ElixirAdvent.read_input(input), "\n")

    twos_and_threes = Enum.map(strings, &check_string/1)
    Enum.reduce(twos_and_threes, 0, fn x, acc -> if Enum.at(x, 0) do acc + 1 else acc end end) *
      Enum.reduce(twos_and_threes, 0, fn x, acc -> if Enum.at(x, 1) do acc + 1 else acc end end)
  end

  def check_string(str) do
    str_list = String.split(str, "", trim: true)
    str_map = Enum.group_by(str_list,  &String.first/1)
    counts = Map.keys(Enum.group_by(Map.values(str_map), fn i -> length(i) end))

    [Enum.member?(counts, 2), Enum.member?(counts, 3)]
  end

  def part2(input) do
    strings = String.split(ElixirAdvent.read_input(input), "\n")
    answer = Enum.reduce_while(strings, [strings, Null], fn str, acc ->
      string_list = Enum.at(acc, 0)
      match = Enum.filter(string_list, fn s -> string_diff_num(s, str) == 1 end)
      if length(match) > 0,
        do: {:halt, [Strings, string_matches(str, Enum.at(match, 0))]},
        else: {:cont, [strings, Null]}
    end)
    Enum.at(answer, 1)
  end

  def string_matches(string1, string2) do
    diff = String.myers_difference(string1, string2)
    eqs = Enum.filter(diff, fn i -> List.first(Tuple.to_list(i)) == :eq end)
    Enum.reduce(eqs, "", fn i, acc -> "#{acc}#{List.last(Tuple.to_list(i))}" end)
  end

  def string_diff_num(string1, string2) do
    matches = string_matches(string1, string2)
    length(String.to_charlist(string1)) - length(String.to_charlist(matches))
  end
end
