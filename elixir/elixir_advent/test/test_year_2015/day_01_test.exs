defmodule ElixirAdvent.Year2015.Day01Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2015.Day01

  test "reduce_parens" do
    cases = [
      ["(())", 0],
      ["(()))", -1],
      ["()()((()", 2]
    ]

    for n <- cases, do: assert ElixirAdvent.Year2015.Day01.reduce_parens(Enum.at(n, 0), 0)
  end
end