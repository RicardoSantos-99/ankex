defmodule AnkexWeb.CardLive.Show do
  use AnkexWeb, :live_view

  alias Ankex.Decks

  @impl true
  def mount(%{"deck_id" => deck_id}, _session, socket) do
    {:ok, socket |> assign(:deck_id, deck_id)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:card, Decks.get_card!(id))}
  end

  defp page_title(:show), do: "Show Card"
  defp page_title(:edit), do: "Edit Card"
end
