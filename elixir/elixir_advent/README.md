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

### Add a new year

Create a new `year_{YYYY}.ex` file in `lib/`

```
defmodule ElixirAdvent.Year2015 do
end
```

Start adding files and tests in `year_{YYYY}` and `test/test_year_{YYYY}` directories

### run all tests
In `elixir_advent`: `mix test`
In repo root: `./gradlew elixir:test`