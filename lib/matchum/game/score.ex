defmodule Matchum.Game.Score do
  defstruct [reds: 0, whites: 0]

  def new(answer, guess) do
    %__MODULE__ {reds: reds(answer,guess), whites: whites(answer, guess)}
  end

  # red = right color, right place
  defp reds(answer, guess) do
    Enum.zip(answer, guess)
    |> Enum.count( fn {a, b} -> a == b end)
  end

  # white = right color, wrong place
  defp whites(answer, guess) do
    ball_count(answer) - reds(answer, guess) - misses(answer, guess)
  end

  # black(misses) = wrong place, wrong color
  defp misses(answer, guess), do: length(guess -- answer)

  defp ball_count(answer), do: length(answer)

end
