defmodule Ankex.DecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ankex.Decks` context.
  """

  defp valid_name, do: "some name"
  defp valid_description, do: "some description"

  def invalid_deck_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: nil,
      description: nil,
      user_id: nil,
      public: true
    })
  end

  def valid_deck_attributes(attrs \\ %{}) do
    user = Ankex.AccountsFixtures.user_fixture()

    Enum.into(attrs, %{
      name: valid_name(),
      description: valid_description(),
      user_id: user.id,
      public: true
    })
  end

  @doc """
  Generate a deck.
  """
  def deck_fixture(attrs \\ %{}) do
    {:ok, deck} =
      attrs
      |> valid_deck_attributes()
      |> Ankex.Decks.create_deck()

    deck
  end
end
