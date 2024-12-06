# Bomber

**Description**
A performance and load testing tool built using Elixir.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed by adding `bomber` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bomber, "~> 0.1.0"}
  ]
end
```

## Usage
1. Clone the repo.
2. From the project root directory, run
```
iex -S mix
```
3. When successfully in the interactive elixir shell, run the below to generate a series of requests to a url endpoint:
```
Bomber.Runner.run("https://example.com", 10)
```
4. Responses are logged to `stdout` and also stored in `logs/bomber.log`.

N.B: This is the basic form of this tool and more optimisations will be made in the coming weeks. Thank you for checking it out.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bomber>.

