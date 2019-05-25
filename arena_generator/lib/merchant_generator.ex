defmodule MerchantGenerator do
  @moduledoc """
  Simple merchant table generator for D&D
  """

  @type merchant_table :: File.t 

  @coins_table %{
    1 => 35,
    2 => 140,
    3 => 280,
    4 => 420,
    5 => 560,
    6 => 4500,
    7 => 8400,
    8 => 12_300,
    9 => 16_200,
    10 => 20_100,
    11 => 24_100,
    12 => 42_400,
    13 => 60_700,
    14 => 79_000,
    15 => 97_300,
    16 => 116_000,
    17 => 134_000,
    18 => 362_000,
    19 => 590_000,
    20 => 818_000
  }
  @prices [
    "Cheap",
    "Normal",
    "Expensive"
  ]

  @doc """
  Generate a merchant table based on player level
  """
  @spec generate_merchant_table(integer) :: merchant_table 
  def generate_merchant_table(player_level) when player_level < 1 or player_level > 20, 
  do: {:error, "Merchant level must be between 1 and 20. Please try again."}

  def generate_merchant_table(player_level) do
    name = Constants.Merchant.random_name
    coins = get_coins_amount(player_level)
    items = Enum.reduce(0..Enum.random(1..10), [], fn _, acc -> acc ++ [get_random_item()] end)
    File.write("./merchant_table_level_#{player_level}.yaml",
      "---\n- name: #{name}\n- coins: #{coins} gp\n- inventory:\n#{for item <- items, do: 
      "    - Item Name: #{Map.get(item, "Item Name")}\n      Price: #{Map.get(item, "#{Enum.random(@prices)}")}\n"}...")
    {:ok, "Merchant table successfully generated. See './merchant_table_level_#{player_level}.yaml'."}
  end

  defp get_coins_amount(player_level) do
    div(@coins_table[player_level], Enum.random(1..player_level))
  end

  defp get_random_item do
    Path.join(File.cwd!(), "config/merchant_items.yaml")
    |> YamlElixir.read_from_file()
    |> elem(1)
    |> Enum.random()
  end
end
