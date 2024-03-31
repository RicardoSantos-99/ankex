defmodule Ankex.Decks.Card do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ankex.Decks.Deck

  @params ~W(front back deck_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :front, :string
    field :back, :string

    belongs_to :deck, Deck

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, @params)
    |> validate_required(@params)
  end
end
