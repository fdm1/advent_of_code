defmodule ElixirAdvent.Year2015.Day02Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2015.Day02

  def test_cases do
    # [dimension string, paper, ribbon]
    [
      ["2x3x4", 58, 34],
      ["1x1x10", 43, 14]
    ]
  end

  def input_string do
    Enum.join(Enum.map(test_cases(), fn(case) -> Enum.at(case, 0) end), "\n")
  end

  test "input_to_dim_list" do
    assert ElixirAdvent.Year2015.Day02.input_to_dim_list(input_string()) == [[2, 3, 4], [1, 1, 10]]
  end


  test "paper_for_box" do
    Enum.map(test_cases(), fn(n) ->
      dim = Enum.map(String.split(Enum.at(n, 0), "x"), fn(i) -> String.to_integer(i) end)
      assert ElixirAdvent.Year2015.Day02.paper_for_box(dim) == Enum.at(n, 1)
    end)
  end

  test "part1" do
    total_sum = Enum.sum(Enum.map(test_cases(), fn(test_case) -> Enum.at(test_case, 1) end))
    assert ElixirAdvent.Year2015.Day02.part1(input_string()) == total_sum
  end

  test "ribbon_for_box" do
    Enum.map(test_cases(), fn(n) ->
      dim = Enum.map(String.split(Enum.at(n, 0), "x"), fn(i) -> String.to_integer(i) end)
      assert ElixirAdvent.Year2015.Day02.ribbon_for_box(dim) == Enum.at(n, 2)
    end)
  end

  test "part2" do
    total_sum = Enum.sum(Enum.map(test_cases(), fn(test_case) -> Enum.at(test_case, 2) end))
    assert ElixirAdvent.Year2015.Day02.part2(input_string()) == total_sum
  end
end
