defmodule Atm.Bank do
  use Atm.Web, :model

  schema "banks" do
    has_many :locations, Atm.Location

    field :name, :string
    field :logo_url, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :logo_url])
    |> validate_required([:name, :logo_url])
  end
end
