defmodule ElixirAdventCLITest do
  use ExUnit.Case
  import Mock
  doctest ElixirAdvent.CLI

  test "main" do
    with_mock ElixirAdvent.Year2015.Day01, [part1: fn(input) -> input end] do
      ElixirAdvent.CLI.main([2015, 1, 1, "foo"])
      assert_called ElixirAdvent.Year2015.Day01.part1("foo")

      ElixirAdvent.CLI.main([2015, 1, 1])
      assert_called ElixirAdvent.Year2015.Day01.part1(nil)
    end
  end
end
