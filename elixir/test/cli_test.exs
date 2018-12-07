defmodule ElixirAdvent.Year2020.Day19 do
  def part29(input) do
    input
  end
end

defmodule ElixirAdventCLITest do
  use ExUnit.Case
  import Mock
  doctest ElixirAdvent.CLI


  ElixirAdventCLITest
  test "main" do
    with_mock ElixirAdvent.Year2015.Day01, [part1: fn(input) -> input end] do
      ElixirAdvent.CLI.main([2015, 1, 1, "foo"])
      assert_called ElixirAdvent.Year2015.Day01.part1("foo")

      ElixirAdvent.CLI.main([2015, 1, 1])
      assert_called ElixirAdvent.Year2015.Day01.part1("../inputs/2015/01.txt")
    end

    with_mock ElixirAdvent.Year2020.Day19, [part29: fn(input) -> input end]  do
      ElixirAdvent.CLI.main([2020, 19, 29])
      assert_called ElixirAdvent.Year2020.Day19.part29("../inputs/2020/19.txt")
    end
  end
end
