defmodule ElixirAdvent.Year2018.Day02Test do
  use ExUnit.Case
  doctest ElixirAdvent.Year2018.Day02

  def part1_test_cases do
    [
      ["abcdef", false, false],
      ["bababc", true, true],
      ["abbcde", true, false],
      ["abcccd", false, true],
      ["aabcdd", true, false],
      ["abcdee", true, false],
      ["ababab", false, true],
    ]
  end

  test "check_string" do
    Enum.map(part1_test_cases(), fn(n) ->
      assert ElixirAdvent.Year2018.Day02.check_string(Enum.at(n, 0)) == [Enum.at(n, 1), Enum.at(n, 2)]
    end)
  end

  test "part1" do
    input = Enum.join(Enum.map(part1_test_cases(), fn x -> Enum.at(x, 0) end), "\n")
    assert ElixirAdvent.Year2018.Day02.part1(input) == 12
  end

  test "string_diff_num" do
    assert ElixirAdvent.Year2018.Day02.string_diff_num("abcde", "axcye") == 2
    assert ElixirAdvent.Year2018.Day02.string_diff_num("fghij", "fguij") == 1
  end

  test "part2" do
    input = "abcde\nfghij\nklmno\npqrst\nfguij\naxcye\nwvxyz"
    assert ElixirAdvent.Year2018.Day02.part2(input) == "fgij"
  end
end
