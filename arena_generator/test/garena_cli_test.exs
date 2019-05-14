defmodule ArenaGeneratorCLITest do
  use ExUnit.Case

  test "parse invalid empty size" do
    refute ArenaGenerator.CLI.main(["--size="])
  end

  test "parse invalid only width" do
    refute ArenaGenerator.CLI.main(["--size=1212"])
  end

  test "parse invalid only height" do
    refute ArenaGenerator.CLI.main(["--size=x1212"])
  end

  test "parse invalid only x" do
    refute ArenaGenerator.CLI.main(["--size=x"])
  end

  test "parse invalid float measurements" do
    refute ArenaGenerator.CLI.main(["--size=12.4x12.4"])
  end

  test "parse valid size" do
    assert ArenaGenerator.CLI.main(["--size=12x12"])
  end
end
