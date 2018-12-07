# ElixirAdvent

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_advent` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_advent, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_advent](https://hexdocs.pm/elixir_advent).


### Building the executable
`mix escript.build`

### Running a solution
After building, `./elixir_advent <year> <day> <part> [input filepath]`

OR `run.sh <year> <day> <part> [input file]`

### Add a new year
Create a new `year_{YYYY}.ex` file in `lib/`

```
defmodule ElixirAdvent.Year2015 do
end
```

### Add a new day
`./bin/create_new_challenge.sh <year> <day>`

### Run all tests
In `elixir_advent`: `mix test`
In repo root: `./gradlew elixir:test`

### Interactive console
`iex -S mix`