defmodule ArenaGenerator.CLI do
  @default_size "12x12"
  @default_level 0
  @default_players 0
  @default_rocks false

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
    |> print_arena
    |> print_treasure?
  end

  defp execute_command(%{help: true}) do
    IO.puts(Constants.CLI.help())
    System.halt(0)
  end

  defp execute_command(%{size: size, rocks: rocks, level: level, players: players}) do
    {width, height} = parse_size(size)
    ArenaGenerator.generate_empty_arena(width, height)
    |> ArenaGenerator.add_rocks(rocks)
    |> ArenaGenerator.add_encounter(level)
    |> ArenaGenerator.add_players(players)
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

  #TODO Fix print width/height
  defp print_arena(arena) do
    for row <- arena, do: IO.puts(row |> elem(1) |> Map.values() |> List.to_string()) 
  end

  defp print_treasure?(_) do
    answer = IO.gets "Print treasure table? (y/n) "
    if answer |> String.downcase |> String.first == "y", do: print_treasure()
  end

  defp print_treasure() do
    Path.join(File.cwd!(), "lib/treasures.yaml")
    |> YamlElixir.read_from_file()
    |> elem(1)
    |> List.first
    |> Map.get("treasure table")
    |> do_print_treasure 
  end

  defp do_print_treasure(treasure) do
    IO.puts "\n"
    IO.puts "Treasure table"
    IO.puts "--------------------"
    IO.puts "Level #{Map.get(treasure, "level")}"
    IO.puts "Coins:"
    Enum.each(Map.get(treasure, "coins"),  fn {k, v} ->
      IO.puts "\t#{k} --> #{v}" end) 
    IO.puts "Treasures:"
    Enum.each(Map.get(treasure, "treasures"), fn treasure ->
      IO.puts "\td100 --> #{get_d100(treasure)}\t\tGems or Art Objects --> #{get_gems_or_art_objects(treasure)}\t\tMagic Items --> #{get_magic_items(treasure)}\n" end)
  end

  defp get_d100(treasure), do: treasure |> Map.get("treasure") |> Map.get("d100")
  defp get_gems_or_art_objects(treasure), do: treasure |> Map.get("treasure") |> Map.get("Gems or Art Objects")
  defp get_magic_items(treasure), do: treasure |> Map.get("treasure") |> Map.get("Magic Items")

  defp parse_args(args) do
    {opts, _, invalid} =
      OptionParser.parse(args,
        strict: [help: :boolean, 
          level: :integer, 
          players: :integer, 
          rocks: :boolean, 
          size: :string],
        aliases: [h: :help, 
          l: :level, 
          p: :players, 
          r: :rocks, 
          s: :size]
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
    opts
    |> Map.put_new(:rocks, @default_rocks)
    |> Map.put_new(:size, @default_size)
    |> Map.put_new(:level, @default_level)
    |> Map.put_new(:players, @default_players)
  end
end
