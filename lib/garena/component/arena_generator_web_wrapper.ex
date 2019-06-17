defmodule Garena.Component.ArenaGeneratorWebWrapper do
  @type arena_params :: map

  @doc """
  Generate and add an arena to arena_params based on params
  """
  @spec add_arena(arena_params) :: arena_params
  def add_arena(arena_params) do
    arena_params = Map.new(arena_params, fn {key, value} -> {key, convert(value)} end)

    arena =
      ArenaGenerator.generate_empty_arena(arena_params["width"], arena_params["height"])
      |> ArenaGenerator.add_rocks(arena_params["rocks"])
      |> ArenaGenerator.add_encounter(arena_params["level"])
      |> ArenaGenerator.add_players(arena_params["players"])
      |> ArenaGenerator.arena_to_string()

    Map.put_new(arena_params, "arena", arena)
  end

  # helper function that converts string to boolean or integer 
  defp convert("true"), do: true
  defp convert("false"), do: false
  defp convert(num), do: String.to_integer(num)
end
