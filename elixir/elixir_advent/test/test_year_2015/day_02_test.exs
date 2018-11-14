defmodule ElixirAdvent.Year2015.Day02Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2015.Day02

  def test_cases do
    [
      ["2x3x4", 58],
      ["1x1x10", 43]
    ]
  end

  test "paper_for_box" do
    for n <- test_cases, do: assert ElixirAdvent.Year2015.Day02.paper_for_box(Enum.at(n, 0)) == Enum.at(n, 1)
  end

  test "part1" do
    input = Enum.join(Enum.map(test_cases, fn(case) -> Enum.at(case, 0) end), "\n")
    total_sum = Enum.sum(Enum.map(test_cases, fn(case) -> Enum.at(case, 1) end))
    assert ElixirAdvent.Year2015.Day02.part1(input) == total_sum
  end
end
