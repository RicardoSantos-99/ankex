defmodule Ankex.DecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ankex.Decks` context.
  """

  @doc """
  Generate a deck.
  """
  def deck_fixture(attrs \\ %{}) do
    {:ok, deck} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        public: true
      })
      |> Ankex.Decks.create_deck()

    deck
  end
end
