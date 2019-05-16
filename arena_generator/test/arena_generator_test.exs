defmodule ArenaGeneratorTest do
  use ExUnit.Case
  doctest ArenaGenerator

  test "generate random size empty arena" do
    width = Enum.random(4..25)
    height = Enum.random(4..25)
    arena = ArenaGenerator.generate_empty_arena(width, height)
    assert map_size(arena) == width 
    for {_column, row} <- arena do 
      assert map_size(row) == height 
    end
  end

  test "generate random arenas with rocks" do
    arenas = []
    for i <- 0..100 do
      width = Enum.random(4..25)
      height = Enum.random(4..25)
      arenas ++ [ArenaGenerator.generate_empty_arena(width, height)]
    end

    for arena <- arenas, do: arena_with_rocks = ArenaGenerator.add_rocks(arena)
  end
end
