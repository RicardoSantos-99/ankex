defmodule Ankex.Study.CardProgress do
  @moduledoc """
  The `Ankex.Decks.CardProgress` schema and changesets.
  """
  use Ecto.Schema
  use TypedStruct

  import Ecto.Changeset

  alias Ankex.Study.StudySession
  alias Ankex.Decks.Card
  alias Ecto.Changeset

  @type t :: %__MODULE__{}

  @params ~W(status study_session_id card_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "study_sessions" do
    field :status, :string
    field :next_interval, :integer
    field :review_date, :naive_datetime

    belongs_to :study_session, StudySession
    belongs_to :card, Card

    timestamps(type: :utc_datetime)
  end

  @doc """
  A CardProgress changeset for creation and updates.
  """
  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(card_progress, attrs) do
    card_progress
    |> cast(attrs, @params)
    |> validate_required(@params)
  end
end
