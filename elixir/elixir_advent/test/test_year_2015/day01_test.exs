defmodule ElixirAdvent.Year2015.Day01Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2015.Day01

  test "greets the world" do
    assert ElixirAdvent.Year2015.Day01.hello() == :world
  end

  test "greets the world 21" do
    assert ElixirAdvent.Year2015.Day01.hello() != :foo
  end
end