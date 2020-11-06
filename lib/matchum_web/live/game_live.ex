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
      assign(socket,
        proposed_guess: [],
        board: Game.new()
      )
      |> build_game()
    }
  end

  def build_game(socket) do
    assign(socket, game: Game.board_to_map(socket.assigns.board))
  end

  def render(assigns) do
    # <%= inspect @board %>
    ~L"""
    <pre>
    <%= live_component @socket, MatchumWeb.Board, game: @game %>
    <div style="display:flex; flex-wrap:wrap; justify-content:center; "><%= raw(render_buttons()) %></div>

    Proposed Guess: <%= raw(render_proposed_guess(@proposed_guess)) %>
    <div style="display:flex; justify-content:center;"><button phx-click="submit" <%= if !valid_guess?(@proposed_guess), do: "disabled" %> > Submit Guess </button>
    <button style="margin-left:10px;" phx-click="clear"> Clear </button></div>
    </pre>
    """
  end

  defp render_buttons() do
    @numbers
    |> Enum.map(fn {code, color} ->
      ~s[<button phx-click="add_item"  phx-value-code="#{code}" phx-value-color="#{color}"
      style="background-color:#{color}; margin:15px; width:150px; text-align:center;">#{String.capitalize(color)}</button>]
    end)
  end

  defp render_proposed_guess(items) do
    for item <- items do
      ~s[<span style="color: #{@numbers[item]}"> (⌐■_■) : #{item} </span>]
    end
  end

  def handle_event("add_item", %{"code" => code, "color" => _color}, socket) do
    {:noreply, add_item(socket, String.to_integer(code))}
  end

  def handle_event("submit", _value, socket) do
    {:noreply, socket |> append_guess |> clear |> build_game}
  end

  def handle_event("clear", _meta, socket) do
    {:noreply, clear(socket)}
  end

  defp valid_guess?(proposed_guess), do: length(proposed_guess) == 4

  defp clear(socket), do: assign(socket, proposed_guess: [])

  defp append_guess(socket) do
    updated_board = Game.move(socket.assigns.board, socket.assigns.proposed_guess)
    assign(socket, board: updated_board)
  end

  defp add_item(%{assigns: %{proposed_guess: guess}} = socket, _color) when length(guess) == 4,
    do: socket

  defp add_item(socket, color) do
    updated_proposed_guess = socket.assigns.proposed_guess ++ [color]
    assign(socket, proposed_guess: updated_proposed_guess)
  end
end
