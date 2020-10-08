defmodule MatchumWeb.GameLive do
  use MatchumWeb, :live_view
  alias Matchum.Game
  import Phoenix.HTML

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, proposed_guess: [], board: Game.new()
      |> Game.move([1, 3, 4, 5]))
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
    <%= raw(render_board(@game)) %>
    Proposed Guess: <%= inspect @proposed_guess %>
    <button phx-click="red" value="8000" style="background-color:red;">Red</button>
    <button style="background-color:blue;">Blue</button>
    <button style="background-color:green;">Green</button>
    <button style="background-color:purple;">Purple</button>
    <button style="background-color:brown;">Brown</button>
    <button style="background-color:salmon;">Salmon</button>
    <button style="background-color:orange;">Orange</button>
    <button> Grade </button>
    <button> Clear </button>
    </pre>
    """
  end

  defp render_board(game) do
    render_rows(game.rows) <> render_status(game.status)
  end

  defp render_rows(rows) do
    for row <- rows do
      """
      <p> #{render_pegs(row.guess)} </p>
      <p> #{inspect row.score.reds} #{inspect row.score.whites} </p>
      """
    end
    |> Enum.join
  end

  defp render_pegs(guess) do
    for peg <- guess do
      ~s[<span style="color: #{color(peg)}"> (⌐■_■) : #{peg} </span>]
    end
  end

  defp color(1), do: "blue"
  defp color(2), do: "green"
  defp color(3), do: "purple"
  defp color(4), do: "brown"
  defp color(5), do: "salmon"
  defp color(6), do: "orange"
  defp color(7), do: "black"
  defp color(8), do: "red"

  defp render_status(status) do
    """
    <div> #{status} </div>
    """
  end

  def handle_event("red", %{"value"=>value}, socket) do
    {:noreply, add_item(socket, String.to_integer(value))}
  end

  defp add_item(socket, color) do
    updated_proposed_guess = socket.assigns.proposed_guess ++ [color]
    assign(socket, proposed_guess: updated_proposed_guess)
  end


end
