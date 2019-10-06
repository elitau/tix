defmodule WallabyExampleApp.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias WallabyExampleApp.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import WallabyExampleAppWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WallabyExampleApp.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(WallabyExampleApp.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(WallabyExampleApp.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
