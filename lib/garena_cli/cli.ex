defmodule ArenaGenerator.CLI do
  @default_merchant_level 1
  @default_player_level 0
  @default_players 0
  @default_scenario_players 4
  @default_rocks false
  @default_size "12x12"
  @default_treasure false

  @moduledoc """
  CLI module for the arena generator
  """

  @doc """
    Parses the command-line arguments and calls the arena generator
  """
  @spec main(String.t()) :: String.t()
  def main([]), do: execute_command(%{help: true})

  def main(args) do
    args
    |> parse_args
    |> sort_opts_into_map
    |> add_default_values
    |> execute_command
  end

  defp execute_command(%{help: true}) do
    IO.puts(Constants.CLI.help())
  end

  defp execute_command(%{scenario: true, players: players}) do
    {_, result} = ScenarioGenerator.generate_random_scenario(players)
    IO.puts result
  end

  defp execute_command(%{merchant: true, level: level}) do
    {_, result} = MerchantGenerator.generate_merchant_table(level)
    IO.puts result 
  end

  defp execute_command(%{
         size: size,
         rocks: rocks,
         level: level,
         players: players,
         treasure: treasure
       }) do
    {width, height} = parse_size(size)

      ArenaGenerator.generate_empty_arena(width, height)
      |> ArenaGenerator.add_rocks(rocks)
      |> ArenaGenerator.add_encounter(level)
      |> ArenaGenerator.add_players(players)
      |> ArenaGenerator.print_arena()
         
    if treasure, do: Treasure.print_treasure()
  end

  defp parse_size(size) do
    if valid_size?(size) do
      [width, height] = String.split(size, ~r/[xX]/, trim: true)
      {String.to_integer(width), String.to_integer(height)}
    else
      IO.puts(Constants.CLI.invalid_size())
      System.halt(1)
    end
  end

  defp valid_size?(size), do: String.match?(size, ~r/^(\d+)x(\d+)$/)

  defp parse_args(args) do
    {opts, _, invalid} =
      OptionParser.parse(args,
        strict: [
          help: :boolean,
          level: :integer,
          merchant: :boolean,
          players: :integer,
          rocks: :boolean,
          scenario: :boolean,
          size: :string,
          treasure: :boolean
        ],
        aliases: [
          h: :help, 
          l: :level, 
          m: :merchant, 
          p: :players, 
          r: :rocks, 
          s: :size, 
          t: :treasure
        ]
      )

    if Enum.empty?(invalid) do
      opts
    else
      IO.puts(Constants.CLI.invalid_argument())
      System.halt(1)
    end
  end

  defp sort_opts_into_map(opts) do
    opts
    |> Enum.sort()
    |> Enum.into(%{})
  end

  defp add_default_values(opts) do
    cond do
      Map.has_key?(opts, :scenario) ->
        opts
        |> Map.put_new(:players, @default_scenario_players)

      Map.has_key?(opts, :merchant) ->
        opts
        |> Map.put_new(:level, @default_merchant_level)

      true ->
        opts
        |> Map.put_new(:level, @default_player_level)
        |> Map.put_new(:players, @default_players)
        |> Map.put_new(:rocks, @default_rocks)
        |> Map.put_new(:size, @default_size)
        |> Map.put_new(:treasure, @default_treasure)
    end
  end
end
