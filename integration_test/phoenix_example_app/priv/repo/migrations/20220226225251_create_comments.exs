defmodule PhoenixExampleApp.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :title, :string
      add :body, :string

      timestamps()
    end
  end
end
