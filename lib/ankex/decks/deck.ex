defmodule Ankex.Decks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ankex.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "decks" do
    field :name, :string
    field :public, :boolean, default: false
    field :description, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deck, attrs) do
    deck
    |> cast(attrs, [:name, :description, :public])
    |> validate_required([:name, :description, :public])
  end
end
