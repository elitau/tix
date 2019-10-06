# Tix

Automatically re-run tests in Elixir's iex console when files are saved. It's like [mix test.watch](https://github.com/lpil/mix-test.watch) but without rebooting the application.

## Usage

Start an iex shell in test env with `MIX_ENV=test iex -S mix` and run `Tix.start()`. Or use the bundled mix task: `MIX_ENV=test iex -S mix tix`

Tix recompiles and executes tests automatically. Only relevant modules (see mix xref and mix test --stale) are recompiled.
The following algorithm is used to choose which test will be executed:

1. Pinned test, if present (pin with `Tix.pin({"/path/to/test.exs", 23})`) ✅
2. Saved file is a test file (ending with `_test.exs`). ✅
3. Saved file has a test sibling (same name as saved file but with `_test.exs`-ending) living in the same folder. ✅
4. Previously executed test if none of the above matches.

### Pin a single test

Sometimes it's useful to focus on a single test and exclude other tests from being executed.

Use `Tix.pin({"path/to/some_test.exs", 23})` so that only this one test will be executed upon save of any file in the project.
Use `Tix.unpin` to restore the above selection algorithm.

## Installation

The package can be installed by adding `tix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tix, "~> 0.3.0", only: :test, runtime: false}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tix](https://hexdocs.pm/tix).

## Issues

* Tests are randomized with the same seed.
* pry session kills itself (after a timeout) and testix with it
* Tags like `@tag :skip` are considered, but not custom ones that are often defined in test_helper.ex
* Only the test helper at test/test_helper.exs is loaded. Other helpers should also be loaded.
  Currently one need to load it by hand with: `TestIex.load_helper("spezifikation/test_helper.exs")`

## (Planned) features

* Usage like https://github.com/nccgroup/sobelow, eg. `mix tix`
* Run all tests
* Set debug breakpoints from within vs-code
* Run only one explicit test on file save

## Development

Run tests with lux. See integration_test folder.
