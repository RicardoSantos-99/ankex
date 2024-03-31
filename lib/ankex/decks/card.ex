defmodule Ankex.Decks.Card do
  @moduledoc """
  The `Ankex.Decks.Card` schema and changesets.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Ankex.Decks.Deck
  alias Ecto.Changeset

  @type t :: %__MODULE__{}
  @params ~W(front back deck_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :front, :string
    field :back, :string

    belongs_to :deck, Deck

    timestamps(type: :utc_datetime)
  end

  @doc """
  A card changeset for creation and updates.
  """
  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(card, attrs) do
    card
    |> cast(attrs, @params)
    |> validate_required(@params)
  end
end
