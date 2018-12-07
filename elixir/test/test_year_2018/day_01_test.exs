defmodule ElixirAdvent.Year2018.Day01Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2018.Day01

  test "input_to_int_list" do
    assert ElixirAdvent.Year2018.Day01.input_to_int_list("+1\n-1\n+12\n-123\n") == [1, -1, 12, -123]
  end

  def part1_test_cases do
    [
      ["+1\n+1\n+1\n", 3],
      ["+1\n+1\n-2\n", 0],
      ["-1\n-2\n-3\n", -6],
    ]
  end

  test "part1" do
    Enum.map(part1_test_cases(), fn(n) ->
      assert ElixirAdvent.Year2018.Day01.part1(Enum.at(n, 0)) == Enum.at(n, 1)
    end)
  end

  def part2_test_cases do
    [
      ["+1\n-1\n", 0],
      ["+3\n+3\n+4\n-2\n-4\n", 10],
      ["-6\n+3\n+8\n+5\n-6\n", 5],
      ["+7\n+7\n-2\n-7\n-4\n", 14],
    ]
  end

  test "part2" do
    Enum.map(part2_test_cases(), fn(n) ->
      assert ElixirAdvent.Year2018.Day01.part2(Enum.at(n, 0)) == Enum.at(n, 1)
    end)
  end
end
