defmodule Matchum.Game.Board do
  defstruct guesses: [], answer: [1, 2, 3, 4]
  alias Matchum.Game.Score

  def new() do
    __struct__(answer: random_answer())
  end

  defp random_answer() do
    1..8
    |> Enum.shuffle()
    |> Enum.take(4)
  end

  def move(board, guess) do
    %{board | guesses: [guess | board.guesses]}
  end

  defp won?(%{guesses: [last_guess | _], answer: last_guess}), do: true

  defp won?(_), do: false

  defp lost?(board) do
    length(board.guesses) == 10 and !won?(board)
  end

  def status(board) do
    cond do
      won?(board) ->
        :won
      lost?(board) ->
        :lost
      true ->
        :playing
    end
  end

  def row(board, guess) do
    %{
      guess: guess,
      score: Score.new(board.answer, guess)
    }
  end

  def all_rows(board) do
    board.guesses
    |> Enum.map(fn(guess) -> row(board, guess)end)
  end

  def to_map(board) do
    %{
      status: status(board),
      rows: all_rows(board)
    }
  end

end
