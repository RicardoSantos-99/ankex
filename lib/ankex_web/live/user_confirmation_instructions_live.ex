defmodule AnkexWeb.UserConfirmationInstructionsLive do
  @moduledoc false
  use AnkexWeb, :live_view

  alias Ankex.Accounts

  @doc false
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        No confirmation instructions received?
        <:subtitle>We'll send a new confirmation link to your inbox</:subtitle>
      </.header>

      <.simple_form for={@form} id="resend_confirmation_form" phx-submit="send_instructions">
        <.core_input field={@form[:email]} type="email" placeholder="Email" required />
        <:actions>
          <.core_button phx-disable-with="Sending..." class="w-full">
            Resend confirmation instructions
          </.core_button>
        </:actions>
      </.simple_form>

      <p class="text-center mt-4">
        <.link href={~p"/users/register"}>Register</.link>
        | <.link href={~p"/users/log_in"}>Log in</.link>
      </p>
    </div>
    """
  end

  @doc false
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  @doc false
  def handle_event("send_instructions", %{"user" => %{"email" => email}}, socket) do
    user = Accounts.get_user_by_email(email)

    if user do
      Accounts.deliver_user_confirmation_instructions(
        user,
        &url(~p"/users/confirm/#{&1}")
      )

      info =
        "If your email is in our system and it has not been confirmed yet, you will receive an email with instructions shortly."

      {:noreply,
       socket
       |> put_flash(:info, info)
       |> redirect(to: ~p"/users/#{user.id}/decks")}
    else
      info = "Invalid email address, please try again."

      {:noreply,
       socket
       |> put_flash(:error, info)
       |> redirect(to: ~p"/users/confirm")}
    end
  end
end
