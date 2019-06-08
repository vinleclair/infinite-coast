defmodule ArenaGenerator do
  @moduledoc """
  Simple arena generator for D&D.
  """

  @type arena :: map

  @doc """
  Generate an empty arena based on width and height input
  """
  @spec generate_empty_arena(integer, integer) :: arena
  def generate_empty_arena(width, height) do
    Enum.reduce(0..(width - 1), %{}, fn x, x_acc ->
      Map.put(
        x_acc,
        x,
        Enum.reduce(0..(height - 1), %{}, fn y, y_acc ->
          Map.put(y_acc, y, "O")
        end)
      )
    end)
  end

  @doc """
  Add rock formations to an existing arena
  """
  @spec add_rocks(arena, boolean) :: arena
  def add_rocks(arena, false), do: arena

  def add_rocks(arena, true) do
    {arena_width, arena_height} = get_arena_dimensions(arena)

    rock_count = div(arena_width * arena_height - 4, 4)

    do_add_rocks(arena, rock_count, arena_width, arena_height)
  end

  defp do_add_rocks(arena, rock_count, _arena_width, _arena_height) when rock_count == 0,
    do: arena

  defp do_add_rocks(arena, rock_count, arena_width, arena_height) do
    rock_cluster_count = Enum.random(1..if(rock_count > 9, do: 9, else: rock_count))

    {x, y} = find_new_rock_cluster_location(arena, arena_width, arena_height)

    {arena, remaining_rock_cluster_count} =
      place_rock_cluster(arena, x, y, rock_cluster_count, [])

    do_add_rocks(
      arena,
      rock_count - (rock_cluster_count - remaining_rock_cluster_count),
      arena_width,
      arena_height
    )
  end

  defp place_rock_cluster(arena, _x, _y, rock_cluster_count, invalids)
       when rock_cluster_count == 0 or length(invalids) == 9,
       do: {arena, rock_cluster_count}

  defp place_rock_cluster(arena, x, y, rock_cluster_count, invalids) do
    {d1, d2} = {Enum.random(-1..1), Enum.random(-1..1)}

    if arena[x + d1][y + d2] not in [nil, "X"] do
      place_rock_cluster(
        put_in(arena[x + d1][y + d2], "X"),
        x,
        y,
        rock_cluster_count - 1,
        invalids
      )
    else
      place_rock_cluster(
        arena,
        x,
        y,
        rock_cluster_count,
        if(!Enum.member?(invalids, [{x + d1, y + d2}]),
          do: invalids ++ [{x + d1, y + d2}],
          else: invalids
        )
      )
    end
  end

  defp find_new_rock_cluster_location(arena, arena_width, arena_height) do
    {x, y} = {Enum.random(0..(arena_width - 1)), Enum.random(0..(arena_height - 1))}

    invalid_location =
      for x2 <- -1..1, do: for(y2 <- -1..1, do: if(arena[x + x2][y + y2] == "X", do: true))

    if invalid_location == true do
      find_new_rock_cluster_location(arena, arena_width, arena_height)
    else
      {x, y}
    end
  end

  @doc """
  Add a random encounter to one side of the arena
  """
  @spec add_encounter(arena, integer) :: arena
  def add_encounter(arena, 0), do: arena

  def add_encounter(arena, level) do
    level
    |> get_random_encounter_from_file
    |> Map.get("enemies")
    |> Enum.reduce([], fn enemy, acc ->
      acc ++ [Map.keys(enemy) |> List.first() |> String.first() |> String.upcase()]
    end)
    |> place_enemy_markers(arena)
  end

  defp get_random_encounter_from_file(level) do
    Path.join(File.cwd!(), "config/tables/encounters.yaml")
    |> YamlElixir.read_from_file()
    |> elem(1)
    |> Enum.filter(&encounter_level?(&1, level))
    |> Enum.random()
    |> Map.get("encounter")
  end

  defp encounter_level?(encounter, level) do
    encounter
    |> Map.get("encounter")
    |> Map.get("level") == level
  end

  defp place_enemy_markers(markers, arena) when length(markers) == 0, do: arena

  defp place_enemy_markers(markers, arena) do
    {arena_width, arena_height} = get_arena_dimensions(arena)
    {x, y} = {Enum.random(0..(arena_width - 1)), Enum.random(0..(div(arena_height, 2) - 1))}
    marker_to_place = Enum.random(markers)

    if arena[x][y] != "O" do
      place_enemy_markers(markers, arena)
    else
      place_enemy_markers(
        List.delete(markers, marker_to_place),
        put_in(arena[x][y], marker_to_place)
      )
    end
  end

  @doc """
  Add players to the other side of the arena
  """
  @spec add_players(arena, integer) :: arena
  def add_players(arena, players) when players <= 0, do: arena

  def add_players(arena, players) do
    {arena_width, arena_height} = get_arena_dimensions(arena)

    {x, y} =
      {Enum.random(0..(arena_width - 1)),
       Enum.random((div(arena_height, 2) - 1)..(arena_height - 1))}

    if arena[x][y] != "O" do
      add_players(arena, players)
    else
      add_players(
        put_in(arena[x][y], "P"),
        players - 1
      )
    end
  end

  @doc """
  Get width and height of the given arena
  """
  @spec get_arena_dimensions(arena) :: integer
  def get_arena_dimensions(arena), do: {map_size(arena), map_size(arena[0])}

  @doc """
  Print the given arena to the device 
  """
  @spec print_arena(IO.device(), arena) :: IO.write()
  def print_arena(device \\ :stdio, arena) do
    {arena_width, arena_height} = get_arena_dimensions(arena)

    for y <- 0..(arena_height - 1) do
      for x <- 0..(arena_width - 1) do
        if x == arena_width - 1 do
          IO.write(device, arena[x][y])
          IO.write(device, "\n")
        else
          IO.write(device, arena[x][y])
        end
      end
    end
  end

  @doc """
  Return the string of the arena
  """
  @spec arena_to_string(arena) :: String.t()
  def arena_to_string(arena) do
    {arena_width, arena_height} = get_arena_dimensions(arena)

    Enum.reduce(0..(arena_height - 1), "", fn y, acc ->
      acc <> Enum.reduce(0..(arena_width - 1), "", fn x, acc2 -> acc2 <> arena[x][y] <> "\t" end) <> "\n"
    end)
  end
end
