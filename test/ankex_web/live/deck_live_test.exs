defmodule AnkexWeb.DeckLiveTest do
  use AnkexWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ankex.DecksFixtures
  import Ankex.AccountsFixtures

  @create_attrs %{name: "new_name", public: true, description: "some description"}
  @update_attrs %{
    name: "some updated name",
    public: false,
    description: "some updated description"
  }
  @invalid_attrs %{name: nil, public: false, description: nil}

  defp create_deck(_) do
    user = user_fixture()
    %{user: user}
  end

  describe "Index" do
    setup [:create_deck]

    test "lists all user decks", %{conn: conn, user: user} do
      deck = deck_fixture(%{user_id: user.id})

      {:ok, _lv, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/users/#{deck.user_id}/decks")

      assert html =~ "Listing Decks"
      assert html =~ deck.name
    end

    test "saves new deck", %{conn: conn, user: user} do
      {:ok, index_live, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/users/#{user.id}/decks")

      assert index_live |> element("a", "New Deck") |> render_click() =~
               "New Deck"

      assert_patch(index_live, ~p"/decks/new")

      assert index_live
             |> form("#deck-form", deck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#deck-form", deck: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users/#{user.id}/decks")

      html = render(index_live)
      assert html =~ "Deck created successfully"
      assert html =~ "new_name"
    end

    test "updates deck in listing", %{conn: conn, user: user} do
      deck = deck_fixture(%{user_id: user.id})

      {:ok, index_live, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/users/#{user.id}/decks")

      assert index_live |> element("#decks-#{deck.id} a", "Edit") |> render_click() =~
               "Edit Deck"

      assert_patch(index_live, ~p"/decks/#{deck}/edit")

      assert index_live
             |> form("#deck-form", deck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#deck-form", deck: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users/#{user.id}/decks")

      html = render(index_live)
      assert html =~ "Deck updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes deck in listing", %{conn: conn, user: user} do
      deck = deck_fixture(%{user_id: user.id})

      {:ok, index_live, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/users/#{user.id}/decks")

      assert index_live |> element("#decks-#{deck.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#decks-#{deck.id}")
    end
  end

  describe "Show" do
    setup [:create_deck]

    test "displays deck", %{conn: conn, user: user} do
      deck = deck_fixture(%{user_id: user.id})

      {:ok, _show_live, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/decks/#{deck}")

      assert html =~ "Show Deck"
      assert html =~ deck.name
    end

    test "updates deck within modal", %{conn: conn, user: user} do
      deck = deck_fixture(%{user_id: user.id})

      {:ok, show_live, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/decks/#{deck}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Deck"

      assert_patch(show_live, ~p"/decks/#{deck}/show/edit")

      assert show_live
             |> form("#deck-form", deck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#deck-form", deck: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/decks/#{deck}")

      html = render(show_live)
      assert html =~ "Deck updated successfully"
      assert html =~ "some updated name"
    end
  end
end
