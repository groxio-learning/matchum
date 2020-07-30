defmodule Matchum.Game.Board do
  defstruct [guesses: [], answer: [1, 2, 3, 4]]
  alias Matchum.Game.Board
    def new() do
      __struct__
    end
end
