defmodule MatchumWeb.GameLive do
  use MatchumWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, message: "hello")}
  end

  def render(assigns) do
    ~L"""
    <h1><%= @message %></h1>
    """
  end
end