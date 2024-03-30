defmodule Ankex.DecksTest do
  use Ankex.DataCase

  alias Ankex.Decks

  describe "decks" do
    alias Ankex.Decks.Deck

    import Ankex.DecksFixtures

    @invalid_attrs %{name: nil, public: nil, description: nil}

    test "list_decks/0 returns all decks" do
      deck = deck_fixture()
      assert Decks.list_decks() == [deck]
    end

    test "get_deck!/1 returns the deck with given id" do
      deck = deck_fixture()
      assert Decks.get_deck!(deck.id) == deck
    end

    test "create_deck/1 with valid data creates a deck" do
      valid_attrs = %{name: "some name", public: true, description: "some description"}

      assert {:ok, %Deck{} = deck} = Decks.create_deck(valid_attrs)
      assert deck.name == "some name"
      assert deck.public == true
      assert deck.description == "some description"
    end

    test "create_deck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck(@invalid_attrs)
    end

    test "update_deck/2 with valid data updates the deck" do
      deck = deck_fixture()
      update_attrs = %{name: "some updated name", public: false, description: "some updated description"}

      assert {:ok, %Deck{} = deck} = Decks.update_deck(deck, update_attrs)
      assert deck.name == "some updated name"
      assert deck.public == false
      assert deck.description == "some updated description"
    end

    test "update_deck/2 with invalid data returns error changeset" do
      deck = deck_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_deck(deck, @invalid_attrs)
      assert deck == Decks.get_deck!(deck.id)
    end

    test "delete_deck/1 deletes the deck" do
      deck = deck_fixture()
      assert {:ok, %Deck{}} = Decks.delete_deck(deck)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck!(deck.id) end
    end

    test "change_deck/1 returns a deck changeset" do
      deck = deck_fixture()
      assert %Ecto.Changeset{} = Decks.change_deck(deck)
    end
  end
end
