defmodule AnkexWeb.DeckLive.Index do
  @moduledoc false
  use AnkexWeb, :live_view

  alias Ankex.Decks
  alias Ankex.Decks.Deck
  alias Ankex.Decks.Card

  @impl true
  @doc false
  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    socket = assign(socket, :current_user, current_user)

    {:ok, stream(socket, :decks, Decks.list_decks_by_user(current_user.id))}
  end

  @impl true
  @doc false
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Deck")
    |> assign(:deck, Decks.get_deck!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Deck")
    |> assign(:deck, %Deck{})
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Card")
    |> assign(:card, %Card{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Decks")
    |> assign(:deck, nil)
  end

  @impl true
  def handle_info({AnkexWeb.DeckLive.FormComponent, {:saved, deck}}, socket) do
    {:noreply, stream_insert(socket, :decks, deck)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    deck = Decks.get_deck!(id)
    {:ok, _} = Decks.delete_deck(deck)

    {:noreply, stream_delete(socket, :decks, deck)}
  end
end
