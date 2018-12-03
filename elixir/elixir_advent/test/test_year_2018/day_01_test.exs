defmodule ElixirAdvent.Year2018.Day01Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2018.Day01

  test "input_to_int_list" do
    assert ElixirAdvent.Year2018.Day01.input_to_int_list("+1\n-1\n+12\n-123\n") == [1, -1, 12, -123]
  end

  def test_cases do
    [
      ["+1\n+1\n+1\n", 3],
      ["+1\n+1\n-2\n", 0],
      ["-1\n-2\n-3\n", -6],
    ]
  end

  test "part1" do
    Enum.map(test_cases(), fn(n) ->
      assert ElixirAdvent.Year2018.Day01.part1(Enum.at(n, 0)) == Enum.at(n, 1)
    end)
  end
end
