defmodule ElixirAdvent.CLI do
  @moduledoc """
  CLI interface for ElixirAdvent
  """

  @doc """
  Entrypoint for Advent of Code in Elixir.
  """

  def inputs_dir(), do: "../inputs"

  def main(args) do
    year = Enum.at(args, 0)
    year = if is_integer(year) do
      Integer.to_string(year)
    else
      year
    end

    day = Enum.at(args, 1)
    day = if is_integer(day) do
      String.pad_leading(Integer.to_string(day), 2, "0")
    else
      String.pad_leading(day, 2, "0")
    end

    part = Enum.at(args, 2)
    part = if is_integer(part) do
      Integer.to_string(part)
    else
      part
    end

    input = if length(args) > 3 do
      Enum.at(args, 3)
    else
      "#{inputs_dir()}/#{year}/#{day}.txt"
    end
    res = run(year, day, part, input)
    IO.puts("\nResult: #{res}")
  end

  def run(year, day, part, input) do
    IO.puts("Running year #{year} day #{day} part #{part} with input #{input}")

    try do
      dayClass = String.to_existing_atom("Elixir.ElixirAdvent.Year#{year}.Day#{day}")
      try do
        apply(dayClass, String.to_atom("part#{part}"), [input])
      rescue
        UndefinedFunctionError -> "Year#{year}.Day#{day}.part#{part} isn't defined"
      end
    rescue
      ArgumentError -> "Year#{year}.Day#{day} doesn't seem to exist"
    end
  end
end