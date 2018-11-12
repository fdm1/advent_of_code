defmodule ElixirAdvent.Year2015.Day01Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2015.Day01

  test "part 1 - reduce_parens" do
    cases = [
      ["(())", 0],
      ["(()))", -1],
      ["()()((()", 2]
    ]

    for n <- cases, do: assert ElixirAdvent.Year2015.Day01.reduce_parens(Enum.at(n, 0)) == Enum.at(n, 1)
  end

  test "part 2" do
    cases = [
      ["(())", 4],
      ["(()))", 5],
      ["()()((()))))", 11]
    ]

    for n <- cases, do: assert ElixirAdvent.Year2015.Day01.reduce_parens(Enum.at(n, 0), true) == Enum.at(n, 1)
  end
end