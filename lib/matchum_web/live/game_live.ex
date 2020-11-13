defmodule MatchumWeb.GameLive do
  use MatchumWeb, :live_view
  alias Matchum.Game
  import Phoenix.HTML

  @numbers %{
    1 => "blue",
    2 => "green",
    3 => "purple",
    4 => "brown",
    5 => "salmon",
    6 => "orange",
    7 => "black",
    8 => "red"
  }

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
    }
  end

  def render(assigns) do
    # <%= inspect @board %>
    ~L"""
    <pre>
    <%= live_component(
      @socket,
      MatchumWeb.Board,
      id: "board_game") %>

    </pre>
    """
  end






end
