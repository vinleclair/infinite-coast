defmodule ArenaGenerator do
  @moduledoc """
  Simple arena generator for D&D.
  """

  @doc """


  ## Examples

  #iex> ArenaGenerator.generate(4, 4)
      "[
        0 0 0 0
        0 0 0 0
        0 0 0 0
        0 0 0 0 
      ]"

  """
  def generate(width, height) do
    grid = Enum.reduce(1..height, [], fn x, h -> 
      h ++ [Enum.reduce(1..width, [], fn y, w -> 
        w ++ if Enum.random(1..10) == 1, do: ["X"], else: ["O"] end)] end)
  end
end
