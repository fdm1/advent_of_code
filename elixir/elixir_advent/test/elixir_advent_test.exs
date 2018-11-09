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
end
