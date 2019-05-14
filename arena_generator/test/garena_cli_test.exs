defmodule ArenaGeneratorCLITest do
  use ExUnit.Case

  @tag :pending
  test "parse invalid empty size" do
    refute ArenaGenerator.CLI.main(["--size="])
  end

  @tag :pending
  test "parse invalid only width" do
    refute ArenaGenerator.CLI.main(["--size=1212"])
  end

  @tag :pending
  test "parse invalid only height" do
    refute ArenaGenerator.CLI.main(["--size=x1212"])
  end

  @tag :pending
  test "parse invalid only x" do
    refute ArenaGenerator.CLI.main(["--size=x"])
  end

  @tag :pending
  test "parse invalid float measurements" do
    refute ArenaGenerator.CLI.main(["--size=12.4x12.4"])
  end

  @tag :pending
  test "parse valid size" do
    assert ArenaGenerator.CLI.main(["--size=12x12"])
  end
end
