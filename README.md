# Tix

Automatically re-run tests in Elixir's iex console when files are saved. It's like [mix test.watch](https://github.com/lpil/mix-test.watch) but without the reboot.

## Usage

Start an iex shell in test env with `MIX_ENV=test iex -S mix` and run `Tix.start()`.

Tix recompiles and executes tests automatically. Only relevant modules (see mix xref and mix test --stale) are recompiled.
The following algorithm is used to choose which test to execute:

1. Pinned test if present (pin with `Tix.pin({"/path/to/test.exs", 23})`)
2. Saved file is a test file (ending with `_test.exs`).✅
3. Saved file has a test sibling (same name as saved file but with `_test.exs`-ending) living in the same folder.✅
4. Previously executed test if none of the above matches.

## Installation

The package can be installed by adding `tix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tix, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tix](https://hexdocs.pm/tix).

## Issues

* Tests are randomized with the same seed.
* pry session kills itself (after a timeout) and testix with it
* Tags like `@tag :skip` are not considered

## (Planned) features

* Usage like https://github.com/nccgroup/sobelow, eg. `mix tix`
* Run all tests
* Set debug breakpoints from within vs-code
* Run only one explicit test on file save
