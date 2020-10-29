defmodule MatchumWeb.Board do
  use MatchumWeb, :live_component

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

  def render(assigns) do
    ~L"""
    <%= raw(render_rows(@game.rows)) %>
    <%= raw(render_status(@game.status)) %>
    """
  end

  defp render_rows(rows) do
    for row <- rows do
      """
      <p> #{render_pegs(row.guess)} </p>
      <p> #{inspect(row.score.reds)} #{inspect(row.score.whites)} </p>
      """
    end
  end

  defp render_status(status) do
    """
    <div> #{status} </div>
    """
  end

  defp render_pegs(guess) do
    for peg <- guess do
      ~s[<span style="color: #{@numbers[peg]}"> (⌐■_■) : #{peg} </span>]
    end
  end
end
