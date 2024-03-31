defmodule AnkexWeb.DeckLive.Show do
  @moduledoc false
  use AnkexWeb, :live_view

  alias Ankex.Decks

  @impl true
  @doc false
  def mount(_params, _session, socket) do
    socket = assign(socket, :current_user, socket.assigns.current_user)

    {:ok, socket}
  end

  @impl true
  @doc false
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:deck, Decks.get_deck!(id))}
  end

  defp page_title(:show), do: "Show Deck"
  defp page_title(:edit), do: "Edit Deck"
end
