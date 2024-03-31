defmodule Ankex.Decks.Deck do
  @moduledoc """
  The `Ankex.Decks.Deck` schema and changesets.
  """
  use Ecto.Schema
  use TypedStruct

  import Ecto.Changeset

  alias Ankex.Accounts.User
  alias Ankex.Decks.Card
  alias Ecto.Changeset

  @type t :: %__MODULE__{}
  @params ~W(name public description user_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "decks" do
    field :name, :string
    field :public, :boolean, default: false
    field :description, :string

    belongs_to :user, User
    has_many :cards, Card

    timestamps(type: :utc_datetime)
  end

  @doc """
  A deck changeset for creation and updates.
  """
  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(deck, attrs) do
    deck
    |> cast(attrs, @params)
    |> validate_required(@params)
    |> unique_constraint([:name, :user_id])
  end
end
