defmodule ArenaGeneratorTest do
  use ExUnit.Case
  doctest ArenaGenerator

  test "generate 4x4" do
    arena = ArenaGenerator.generate(4,4)
    assert length(arena) == 4
    for row <- arena do 
      assert length(row) == 4 
    end
  end
end
