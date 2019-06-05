defmodule ScenarioGeneratorTest do
  use ExUnit.Case
  doctest ScenarioGenerator

  test "generate a random scenario then delete it" do
    players = Enum.random(1..4)
    {:ok, message} = ScenarioGenerator.generate_random_scenario(players)

    filepath =
      message
      |> String.split(~r/'(.*?)'/, include_captures: true)
      |> Enum.at(1)
      |> String.replace("'", "")

    assert File.exists?(filepath)
    File.rm(filepath)
    refute File.exists?(filepath)
  end
end
