defmodule Matchum.Game do
  alias Matchum.Game.{Board, Score}

  def board_to_map(board) do
   rows = Enum.map(board.guesses, &row(&1, board.answer))
   %{
     rows: rows,
     status: Board.status(board),
   }
  end

  def row(guess, answer) do
    %{guess: guess, score: Score.new(answer, guess)}
  end

  def new(), do: Board.new()

  def move(board, guess), do: Board.move(board, guess)
end
