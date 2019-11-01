# 2018 - Day 03: http://adventofcode.com/2018/day/3

defmodule ElixirAdvent.Year2018.Day03 do
  def part1(input) do
    rects = Enum.map(Enum.map(String.split(ElixirAdvent.read_input(input), "\n"), &parse_rect/1), &rect_points/1)

    all_int = Enum.reduce(rects, [Enum.drop(rects, 1), []], fn rect, acc ->
      new_rects = Enum.at(acc, 0)
      all_intersects = Enum.at(acc, 1)
      new_intersects = MapSet.new()
      new_intersects = for r <- new_rects do
        MapSet.union(new_intersects, intersect(rect, r))
      end
      [Enum.drop(new_rects, 1), MapSet.union(all_intersects, new_intersects)]
    end)

    length(Enum.at(all_int, 1))

  end

  def parse_rect(input_str) do
    Enum.drop(
      Enum.map(
        Enum.filter(
          String.split(input_str, ""), fn i -> Regex.match?(~r/[0-9]/, i) end),
        fn i -> String.to_integer(i) end
      ),
    1)
  end

  def rect_points(rect_specs) do
    res = MapSet.new()
    for h <- Range.new(0, Enum.at(rect_specs, 2)-1) do
      for w <- Range.new(0, Enum.at(rect_specs, 3)-1) do
        MapSet.put(res, [Enum.at(rect_specs, 0) + h, Enum.at(rect_specs, 1) + w])
      end
    end
#    Enum.reduce(List.flatten(res), fn i, acc -> MapSet.union(i, acc) end)
  end

  def intersect(points1, points2) do
    MapSet.intersection(points1, points2)
  end

  def part2(input) do
    ElixirAdvent.read_input(input)
  end
end
