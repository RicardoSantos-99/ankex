defmodule Ankex.Study do
  @moduledoc """
  The StudySession context.
  """

  alias Ecto.Multi

  import Ecto.Query, warn: false
  alias Ankex.Decks
  alias Ankex.Repo

  alias Ankex.Study.StudySession
  alias Ankex.Study.CardProgress

  def create_study_session(%{deck_id: deck_id} = attrs) do
    Multi.new()
    |> Multi.run(:create_session, fn _repo, _changes -> create_session(attrs) end)
    |> Multi.run(:clone_cards, fn _repo, %{create_session: session} ->
      clone_cards_for_session(session, deck_id)
    end)
    |> Repo.transaction()
    |> handle_transaction_result()
  end

  def create_session(attrs) do
    %StudySession{}
    |> StudySession.changeset(attrs)
    |> Repo.insert()
  end

  defp clone_cards_for_session(session, deck_id) do
    deck_id
    |> Decks.list_cards()
    |> Enum.map(fn card ->
      attrs =
        %{
          study_session_id: session.id,
          card_id: card.id,
          status: "not_reviewed",
          review_date: nil,
          next_interval: nil
        }

      %CardProgress{}
      |> CardProgress.changeset(attrs)
      |> IO.inspect()
      |> Repo.insert()
    end)
    |> Enum.all?(fn
      {:ok, _} -> {:ok, nil}
      {:error, changes} -> {:error, changes}
    end)
  end

  defp handle_transaction_result({:ok, %{create_session: session}}) do
    {:ok, session}
  end

  defp handle_transaction_result({:error, :create_session, reason, _changes}) do
    {:error, :failed_to_create_session, reason}
  end

  defp handle_transaction_result({:error, :clone_cards, reason, _changes}) do
    {:error, :failed_to_clone_cards, reason}
  end
end
