defmodule Treasure do
  @moduledoc """
  Simple treasure table generator for D&D
  """

  @doc """
  Print a treasure table
  """
  @spec print_treasure() :: IO.puts()
  def print_treasure() do
    Path.join(File.cwd!(), "config/tables/treasures.yaml")
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
end
