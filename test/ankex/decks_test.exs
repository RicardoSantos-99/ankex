defmodule Ankex.DecksTest do
  use Ankex.DataCase, async: true

  import Ankex.DecksFixtures
  import Ankex.DecksFixtures

  alias Ankex.Decks
  alias Ankex.Decks.Deck
  alias Ecto.NoResultsError
  alias Ecto.Changeset
  alias Ankex.Decks.Card

  describe "decks" do
    test "list_decks/0 returns all decks" do
      deck = deck_fixture()
      assert Decks.list_decks() == [deck]
    end

    test "get_deck!/1 returns the deck with given id" do
      deck = deck_fixture()
      assert Decks.get_deck!(deck.id) == deck
    end

    test "create_deck/1 with valid data creates a deck" do
      valid_attrs = valid_deck_attributes()

      assert {:ok, %Deck{} = deck} = Decks.create_deck(valid_attrs)
      assert deck.name == "some name"
      assert deck.public == true
      assert deck.description == "some description"
    end

    test "create_deck/1 with invalid data returns error changeset" do
      invalid_attrs = invalid_deck_attributes()
      assert {:error, %Changeset{}} = Decks.create_deck(invalid_attrs)
    end

    test "update_deck/2 with valid data updates the deck" do
      deck = deck_fixture()

      update_attrs = %{
        name: "some updated name",
        public: false,
        description: "some updated description"
      }

      assert {:ok, %Deck{} = deck} = Decks.update_deck(deck, update_attrs)
      assert deck.name == "some updated name"
      assert deck.public == false
      assert deck.description == "some updated description"
    end

    test "update_deck/2 with invalid data returns error changeset" do
      invalid_attrs = invalid_deck_attributes()
      deck = deck_fixture()
      assert {:error, %Changeset{}} = Decks.update_deck(deck, invalid_attrs)
      assert deck == Decks.get_deck!(deck.id)
    end

    test "delete_deck/1 deletes the deck" do
      deck = deck_fixture()
      assert {:ok, %Deck{}} = Decks.delete_deck(deck)
      assert_raise NoResultsError, fn -> Decks.get_deck!(deck.id) end
    end

    test "change_deck/1 returns a deck changeset" do
      deck = deck_fixture()
      assert %Changeset{} = Decks.change_deck(deck)
    end
  end

  describe "cards" do
    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Decks.list_cards(card.deck_id) == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Decks.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      valid_attrs = valid_card_attributes()

      assert {:ok, %Card{} = card} = Decks.create_card(valid_attrs)
      assert card.front == "some front"
      assert card.back == "some back"
    end

    test "create_card/1 with invalid data returns error changeset" do
      invalid_attrs = %{front: nil, back: nil}
      assert {:error, %Ecto.Changeset{}} = Decks.create_card(invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      update_attrs = %{front: "some updated front", back: "some updated back"}

      assert {:ok, %Card{} = card} = Decks.update_card(card, update_attrs)
      assert card.front == "some updated front"
      assert card.back == "some updated back"
    end

    test "update_card/2 with invalid data returns error changeset" do
      invalid_attrs = %{front: nil, back: nil}
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_card(card, invalid_attrs)
      assert card == Decks.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Decks.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Decks.change_card(card)
    end
  end
end
