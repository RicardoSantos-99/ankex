defmodule Ankex.Decks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ankex.Accounts.User

  @params ~W(name public description user_id)a

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
    |> cast(attrs, @params)
    |> validate_required(@params)
    |> unique_constraint([:name, :user_id])
  end
end
