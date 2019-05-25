defmodule ArenaGenerator.CLI do
  @default_merchant_level 1
  @default_player_level 0
  @default_players 0
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
    |> print_arena
  end

  defp execute_command(%{help: true}) do
    IO.puts(Constants.CLI.help())
    System.halt(0)
  end

  defp execute_command(%{merchant: true, level: level}) do
    {_, result} = MerchantGenerator.generate_merchant_table(level)
    IO.puts result 
    System.halt(0)
  end

  defp execute_command(%{
         size: size,
         rocks: rocks,
         level: level,
         players: players,
         treasure: treasure
       }) do
    {width, height} = parse_size(size)

    arena =
      ArenaGenerator.generate_empty_arena(width, height)
      |> ArenaGenerator.add_rocks(rocks)
      |> ArenaGenerator.add_encounter(level)
      |> ArenaGenerator.add_players(players)

    {arena, treasure}
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

  defp print_arena({arena, treasure}) do
    {arena_width, arena_height} = ArenaGenerator.get_arena_dimensions(arena)

    for y <- 0..(arena_height - 1) do
      for x <- 0..(arena_width - 1) do
        if x == arena_width - 1 do
          IO.write(arena[x][y])
          IO.write("\n")
        else
          IO.write(arena[x][y])
        end
      end
    end

    if treasure, do: print_treasure()
  end

  defp print_treasure() do
    Path.join(File.cwd!(), "config/treasures.yaml")
    |> YamlElixir.read_from_file()
    |> elem(1)
    |> List.first()
    |> Map.get("treasure table")
    |> do_print_treasure
  end

  defp do_print_treasure(treasure) do
    IO.puts("\n")
    IO.puts("Treasure table")
    IO.puts("--------------------")
    IO.puts("Level #{Map.get(treasure, "level")}")
    IO.puts("Coins:")

    Enum.each(Map.get(treasure, "coins"), fn {k, v} ->
      IO.puts("\t#{k} --> #{v}")
    end)

    IO.puts("Treasures:")

    Enum.each(Map.get(treasure, "treasures"), fn treasure ->
      IO.puts(
        "\td100 --> #{get_d100(treasure)}\t\tGems or Art Objects --> #{
          get_gems_or_art_objects(treasure)
        }\t\tMagic Items --> #{get_magic_items(treasure)}\n"
      )
    end)
  end

  defp get_d100(treasure), do: treasure |> Map.get("treasure") |> Map.get("d100")

  defp get_gems_or_art_objects(treasure),
    do: treasure |> Map.get("treasure") |> Map.get("Gems or Art Objects")

  defp get_magic_items(treasure), do: treasure |> Map.get("treasure") |> Map.get("Magic Items")

  defp parse_args(args) do
    {opts, _, invalid} =
      OptionParser.parse(args,
        strict: [
          help: :boolean,
          level: :integer,
          merchant: :boolean,
          players: :integer,
          rocks: :boolean,
          size: :string,
          treasure: :boolean
        ],
        aliases: [h: :help, l: :level, m: :merchant, p: :players, r: :rocks, s: :size, t: :treasure]
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
