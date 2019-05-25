defmodule ScenarioGenerator do
  @moduledoc """
  Generate an entire D&D scenario
  """

  @type scenario :: File.t()

  @min_width 6
  @max_width 24
  @min_height 6
  @max_height 24
  @min_amount_arenas 2
  @max_amount_arenas 10

  @doc """
  Generate a random scenario
  """
  @spec generate_random_scenario(integer) :: scenario
  def generate_random_scenario(players) do
    file_name = get_file_name()
    arenas =
      Enum.reduce(random_arena_amount(), [], fn _, acc ->
        acc ++
          [
            ArenaGenerator.generate_empty_arena(random_width(), random_height())
            |> ArenaGenerator.add_rocks(Enum.random([true, false]))
            |> ArenaGenerator.add_players(players)
            |> ArenaGenerator.add_encounter(Enum.random(0..2))
          ]
      end)

    {:ok, scenario_file} = File.open("./scenario_#{file_name}.txt", [:write])

    for arena <- arenas do
      IO.puts(scenario_file, "Arena #{Enum.find_index(arenas, &(&1 == arena))}")
      IO.puts(scenario_file, "----------")
      ArenaGenerator.print_arena(scenario_file, arena)
      IO.puts(scenario_file, "")
    end

    File.close(scenario_file)
    {:ok, 
      "Scenario successfully generated. See './scenario_#{file_name}.txt'."}
  end

  defp get_file_name do
    Constants.Scenario.random_name()
    |> String.downcase()
    |> String.replace(" ", "_")
  end

  defp random_arena_amount,
    do: @min_amount_arenas..Enum.random(@min_amount_arenas..@max_amount_arenas)

  defp random_width, do: Enum.random(@min_width..@max_width)
  defp random_height, do: Enum.random(@min_height..@max_height)
end
