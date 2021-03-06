defmodule ElixirAdvent do
  @moduledoc """
  Documentation for ElixirAdvent.
  """

  @doc """
  Entrypoint for Advent of Code in Elixir. This will contain all the utilities for reading and transforming input to be used by all challenges

  ## Examples
      iex> ElixirAdvent.read_input("test/resources/test_input_file.txt")
      "123"

  """

  def read_input(file_path) do
    if File.exists?(file_path) do
      File.read!(file_path)
    else
      file_path
    end
  end
end
