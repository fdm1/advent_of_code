defmodule ElixirAdvent.Year2015.Day03Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2015.Day03

  test "directions_to_list" do
    assert ElixirAdvent.Year2015.Day03.directions_to_list("<<^^>>vv") == ["<", "<", "^", "^", ">", ">", "v", "v"]
  end

  test "part1" do
    assert ElixirAdvent.Year2015.Day03.part1(">") == 2
  end
end
