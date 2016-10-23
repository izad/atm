defmodule Atm.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :bank_id, references(:banks)

      add :name, :string
      add :address, :text
      add :lat, :float
      add :lng, :float

      timestamps()
    end

    create index(:locations, [:bank_id])
  end
end
