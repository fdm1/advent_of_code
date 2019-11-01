defmodule ElixirAdvent.Year2018.Day03Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2018.Day03

  test "part1" do
    input = "#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2"
    assert ElixirAdvent.Year2018.Day03.part1(input) == 4
  end

  test "parse_rect" do
    assert ElixirAdvent.Year2018.Day03.parse_rect("#1 @ 1,3: 4x4") == [1, 3, 4, 4]
  end

  test "rect_points" do
    assert ElixirAdvent.Year2018.Day03.rect_points([1,3, 4, 4]) == MapSet.new([
      [1,3], [1, 4], [1, 5], [1, 6],
      [2,3], [2, 4], [2, 5], [2, 6],
      [3,3], [3, 4], [3, 5], [3, 6],
      [4,3], [4, 4], [4, 5], [4, 6]
    ])
  end

  test "intersect" do
    rect1 = MapSet.new([
      [1,3], [1, 4], [1, 5], [1, 6],
      [2,3], [2, 4], [2, 5], [2, 6],
      [3,3], [3, 4], [3, 5], [3, 6],
      [4,3], [4, 4], [4, 5], [4, 6]
    ])

    rect2 = MapSet.new([
      [3, 1], [3, 2], [3, 3], [3, 4],
      [4, 1], [4, 2], [4, 3], [4, 4],
      [5, 1], [5, 2], [5, 3], [5, 4],
      [6, 1], [6, 2], [6, 3], [6, 4]
    ])

    intersection = MapSet.new([
      [3,3], [3, 4],
      [4,3], [4, 4]
    ])
    assert ElixirAdvent.Year2018.Day03.intersect(rect1, rect2) == intersection
  end

  test "part2" do
    input = ""
    answer = ""
    assert ElixirAdvent.Year2018.Day03.part2(input) == ""
  end
end
