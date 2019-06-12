defmodule ArenaGeneratorTest do
  use ExUnit.Case
  use Garena.DataCase
  import ExUnit.CaptureIO
  doctest ArenaGenerator

  test "generate one hundred random size empty arenas" do
    for _ <- 0..100 do
      width = Enum.random(4..25)
      height = Enum.random(4..25)
      arena = ArenaGenerator.generate_empty_arena(width, height)

      assert {width, height} == ArenaGenerator.get_arena_dimensions(arena)
    end
  end

  test "generate one hundred random arenas with rocks" do
    for _ <- 0..100 do
      rocky_arena = generate_random_arena() |> ArenaGenerator.add_rocks(true)

      rock_count =
        for(
          row <- rocky_arena,
          do: row |> elem(1) |> Map.values() |> Enum.count(fn square -> square == "X" end)
        )
        |> Enum.sum()

      {width, height} = ArenaGenerator.get_arena_dimensions(rocky_arena)
      assert rock_count == div(width * height - 4, 4)
    end
  end

  test "generate one hundred random arenas with enemies" do
    for _ <- 0..100 do
      level = Enum.random(0..20)
      encounter_arena = generate_random_arena() |> ArenaGenerator.add_encounter(level)

      enemy_count =
        for(
          row <- encounter_arena,
          do:
            row
            |> elem(1)
            |> Map.values()
            |> Enum.count(fn square -> square not in ["O", "X"] end)
        )
        |> Enum.sum()

      assert enemy_count > 0
    end
  end

  test "generate one hundred random arenas with players" do
    for _ <- 0..100 do
      players = Enum.random(0..4)
      player_arena = generate_random_arena() |> ArenaGenerator.add_players(players)

      player_count =
        for(
          row <- player_arena,
          do: row |> elem(1) |> Map.values() |> Enum.count(fn square -> square == "P" end)
        )
        |> Enum.sum()

      assert player_count == players
    end
  end

  test "convert arena to string" do
    assert ArenaGenerator.generate_empty_arena(3, 3) |> ArenaGenerator.arena_to_string() ==
             "O\tO\tO\t\nO\tO\tO\t\nO\tO\tO\t\n"
  end

  test "print arena" do
    arena = ArenaGenerator.generate_empty_arena(4, 4) 
    assert capture_io(fn -> ArenaGenerator.print_arena(arena) end) == "OOOO\nOOOO\nOOOO\nOOOO\n"
  end
end
