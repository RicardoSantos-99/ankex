defmodule AnkexWeb.CardLive.Index do
  use AnkexWeb, :live_view

  alias Ankex.Decks
  alias Ankex.Decks.Card

  @impl true
  def mount(%{"deck_id" => deck_id}, _session, socket) do
    {:ok,
     socket
     |> stream(:cards, Decks.list_cards(deck_id))
     |> assign(:deck_id, deck_id)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Card")
    |> assign(:card, Decks.get_card!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Card")
    |> assign(:card, %Card{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cards")
    |> assign(:card, nil)
  end

  @impl true
  def handle_info({AnkexWeb.CardLive.FormComponent, {:saved, card}}, socket) do
    {:noreply, stream_insert(socket, :cards, card)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    card = Decks.get_card!(id)
    {:ok, _} = Decks.delete_card(card)

    {:noreply, stream_delete(socket, :cards, card)}
  end
end
