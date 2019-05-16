defmodule ArenaGenerator do

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
  @spec add_rocks(map) :: map 
  def add_rocks(arena) do
    arena_width = map_size(arena)
    arena_height = map_size(arena[0])
    rock_count = div((arena_width * arena_height) - 4, 4) 

    do_add_rocks(arena, rock_count, arena_width, arena_height)
  end

  defp do_add_rocks(arena, rock_count, _arena_width, _arena_height) when rock_count == 0, do: arena

  defp do_add_rocks(arena, rock_count, arena_width, arena_height) do
    rock_cluster_count = Enum.random(1..(if rock_count > 9, do: 9, else: rock_count))
    {x, y} = find_new_rock_cluster_location(arena, arena_width, arena_height)
    {arena, remaining_rock_cluster_count} = add_rock_cluster(arena, x, y, rock_cluster_count, [])
    do_add_rocks(arena,
      rock_count - (rock_cluster_count - remaining_rock_cluster_count),
      arena_width,
      arena_height)
  end

  defp add_rock_cluster(arena, _x, _y, rock_cluster_count, invalids) when rock_cluster_count == 0 or length(invalids) == 9, do: {arena, rock_cluster_count}

  defp add_rock_cluster(arena, x, y, rock_cluster_count, invalids) do
    {d1, d2} = {Enum.random(-1..1), Enum.random(-1..1)}

    if arena[x + d1][y + d2] not in [nil, "X"] do 
      add_rock_cluster(put_in(arena[x + d1][y + d2], "X"),
        x,
        y,
        rock_cluster_count - 1,
        invalids)
    else
      add_rock_cluster(arena, x, y, rock_cluster_count, 
        (if !Enum.member?(invalids, [{x + d1, y + d2}]), do: invalids ++ [{x + d1, y + d2}], else: invalids))
    end
  end


  defp find_new_rock_cluster_location(arena, arena_width, arena_height) do 
    {x, y} = {Enum.random(0..arena_width - 1), Enum.random(0..arena_height - 1)}
    invalid_location = false

    for x2 <- -1..1 do
      for y2 <- -1..1 do
        if arena[x + x2][y + y2] == "X", do: invalid_location = true 
      end
    end
    
    if invalid_location == true do
      find_new_rock_cluster_location(arena, arena_width, arena_height)
    else
      {x, y}
    end
  end

end

