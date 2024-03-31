defmodule AnkexWeb.CardLiveTest do
  use AnkexWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Ankex.DecksFixtures
  import Ankex.AccountsFixtures

  @create_attrs %{front: "some front", back: "some back"}
  @update_attrs %{front: "some updated front", back: "some updated back"}
  @invalid_attrs %{front: nil, back: nil}

  defp create_card(_) do
    user = user_fixture()
    card = card_fixture(%{user_id: user.id})
    %{card: card, user: user}
  end

  describe "Index" do
    setup [:create_card]

    test "lists all cards", %{conn: conn, card: card, user: user} do
      {:ok, _index_live, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/decks/#{card.deck_id}/cards")

      assert html =~ "Listing Cards"
      assert html =~ card.front
    end

    test "saves new card", %{conn: conn, card: card, user: user} do
      {:ok, index_live, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/decks/#{card.deck_id}/cards")

      assert index_live |> element("a", "New Card") |> render_click() =~
               "New Card"

      assert_patch(index_live, ~p"/cards/new")

      assert index_live
             |> form("#card-form", card: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#card-form", card: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/decks/#{card.deck_id}/cards")

      html = render(index_live)
      assert html =~ "Card created successfully"
      assert html =~ "some front"
    end

    test "updates card in listing", %{conn: conn, card: card, user: user} do
      {:ok, index_live, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/decks/#{card.deck_id}/cards")

      assert index_live |> element("#cards-#{card.id} a", "Edit") |> render_click() =~
               "Edit Card"

      assert_patch(index_live, ~p"/decks/#{card.deck_id}/cards/#{card}/edit")

      assert index_live
             |> form("#card-form", card: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#card-form", card: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/decks/#{card.deck_id}/cards")

      html = render(index_live)
      assert html =~ "Card updated successfully"
      assert html =~ "some updated front"
    end

    test "deletes card in listing", %{conn: conn, card: card, user: user} do
      {:ok, index_live, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/decks/#{card.deck_id}/cards")

      assert index_live |> element("#cards-#{card.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cards-#{card.id}")
    end
  end

  describe "Show" do
    setup [:create_card]

    test "displays card", %{conn: conn, card: card, user: user} do
      {:ok, _show_live, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/decks/#{card.deck_id}/cards/#{card}")

      assert html =~ "Show Card"
      assert html =~ card.front
    end

    test "updates card within modal", %{conn: conn, card: card, user: user} do
      {:ok, show_live, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/decks/#{card.deck_id}/cards/#{card}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Card"

      assert_patch(show_live, ~p"/cards/#{card}/show/edit")

      assert show_live
             |> form("#card-form", card: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#card-form", card: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/decks/#{card.deck_id}/cards/#{card}")

      html = render(show_live)
      assert html =~ "Card updated successfully"
      assert html =~ "some updated front"
    end
  end
end
