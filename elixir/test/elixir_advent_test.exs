defmodule ElixirAdventTest do
  use ExUnit.Case
  doctest ElixirAdvent

  test "reading an input file" do
    test_content = "some content\nfoobar"
    {:ok, file_path} = Temp.open "my-file", &IO.write(&1, test_content)

    input = ElixirAdvent.read_input(file_path)
    assert input == test_content

    File.rm file_path
  end

  test "reading an stdin" do
    test_content = "this is\n not a filepath"

    input = ElixirAdvent.read_input(test_content)
    assert input == test_content
  end
end
