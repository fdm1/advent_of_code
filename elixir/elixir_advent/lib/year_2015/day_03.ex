# 2015 - Day 03: http://adventofcode.com/2015/day/3

defmodule ElixirAdvent.Year2015.Day03 do
  def part1(input) do
    directions = directions_to_list(input)

    current_position = [0,0]
    houses = MapSet.new([current_position])

    for d <- directions do
      current_position = move(current_position, d)
      houses = MapSet.put(houses, current_position)
      IO.inspect(houses)
      IO.inspect(current_position)
    end

    IO.inspect(houses)
    IO.puts("current size is #{MapSet.size(houses)}")
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
