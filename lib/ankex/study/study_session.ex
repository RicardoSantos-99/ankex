defmodule Ankex.Study.StudySession do
  @moduledoc """
  The `Ankex.Decks.StudySession` schema and changesets.
  """
  use Ecto.Schema
  use TypedStruct

  import Ecto.Changeset

  alias Ankex.Accounts.User
  alias Ankex.Decks.Deck
  alias Ecto.Changeset

  @type t :: %__MODULE__{}
  @params ~W(end_time start_time deck_id user_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "study_sessions" do
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime

    belongs_to :user, User
    belongs_to :deck, Deck

    timestamps(type: :utc_datetime)
  end

  @doc """
  A StudySession changeset for creation and updates.
  """
  @spec changeset(map(), map()) :: Changeset.t()
  def changeset(study_session, attrs) do
    required = @params -- ~W(end_time)a

    study_session
    |> cast(attrs, @params)
    |> validate_required(required)
  end
end
