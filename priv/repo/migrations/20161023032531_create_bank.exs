defmodule Atm.Repo.Migrations.CreateBank do
  use Ecto.Migration

  def change do
    create table(:banks) do
      add :name, :string
      add :logo_url, :string

      timestamps()
    end

  end
end
