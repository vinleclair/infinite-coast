defmodule Garena.Component.MerchantGeneratorWebWrapper do
  @type merchant_params :: map
  @type merchant :: map

  @prices [
    "Cheap",
    "Normal",
    "Expensive"
  ]

  @doc """
  Generate a merchant based on level
  """
  @spec add_merchant(merchant_params) :: merchant
  def add_merchant(merchant_params) do
    merchant =
      MerchantGenerator.generate_merchant(merchant_params["level"] |> String.to_integer())

    Map.put(merchant, "items", parse_items(merchant["items"]))
  end

  defp parse_items(items) do
    Enum.reduce(items, "", fn item, acc ->
      acc <>
        "#{Map.get(item, "Item Name")}: #{Map.get(item, "#{Enum.random(@prices)}")}\n"
    end)
  end
end
