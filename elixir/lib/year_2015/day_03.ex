# 2015 - Day 03: http://adventofcode.com/2015/day/3

defmodule ElixirAdvent.Year2015.Day03 do
  def part1(input) do
    directions = directions_to_list(ElixirAdvent.read_input(input))

    reduced = Enum.reduce(directions, [[0, 0], MapSet.new([[0, 0]])], fn direction, acc ->
      current_position = move(Enum.at(acc, 0), direction)
      [current_position, MapSet.put(Enum.at(acc, 1), current_position)]
    end)

    houses = Enum.at(reduced, 1)
    MapSet.size(houses)
  end

  def part2(input) do
    ElixirAdvent.read_input(input)
  end

  def move(position, direction) do
    case (direction) do
      ">" -> [Enum.at(position, 0) + 1, Enum.at(position, 1)]
      "<" -> [Enum.at(position, 0) - 1, Enum.at(position, 1)]
      "^" -> [Enum.at(position, 0), Enum.at(position, 1) + 1]
      "v" -> [Enum.at(position, 0), Enum.at(position, 1) - 1]
    end
  end

  def directions_to_list(input) do
    List.delete(String.split(input, "", trim: True), "")
  end
end
