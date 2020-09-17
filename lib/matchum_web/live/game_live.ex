defmodule MatchumWeb.GameLive do
  use MatchumWeb, :live_view
  alias Matchum.Game

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, board: Game.new())
      |> build_game()
    }
  end

  def build_game(socket) do
    assign(socket, game: Game.board_to_map(socket.assigns.board))
  end

  def render(assigns) do
    ~L"""
    <pre>
    <%= inspect @board %>
    <%= inspect @game %>
    </pre>
    """
  end
end
