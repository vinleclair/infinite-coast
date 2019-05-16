defmodule ArenaGenerator do
  @rocks_spawn_chance 30
  @rock_count 5 #TODO Turn this into a flag

  @moduledoc """
  Simple arena generator for D&D.
  """

  @doc """
  Generate an empty arena based on width and height input
  """
  @spec generate_empty_arena(integer, integer) :: List
  def generate_empty_arena(width, height) do
    Enum.reduce(0..width - 1, %{}, fn x, x_acc -> 
      Map.put(x_acc, x, Enum.reduce(0..height - 1, %{}, fn y, y_acc -> 
        Map.put(y_acc, y, "O") 
      end)) 
    end)
  end

  @doc """
  Add rock formations to an existing arena
  """
  @spec add_rocks(List) :: List
  def add_rocks(arena) do
    #TODO implement
  end

  defp do_add_rocks(arena, rock_count) when rock_count == 0, do: arena

end
