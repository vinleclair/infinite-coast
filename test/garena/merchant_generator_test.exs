defmodule MerchantGeneratorTest do
  use ExUnit.Case
  doctest MerchantGenerator

  test "generate a random merchant table then delete it" do
    level = Enum.random(1..20)
    MerchantGenerator.generate_merchant_table(level)
    assert File.exists?("./merchant_table_level_#{level}.yaml")
    File.rm("./merchant_table_level_#{level}.yaml")
    refute File.exists?("./merchant_table_level_#{level}.yaml")
  end
end
