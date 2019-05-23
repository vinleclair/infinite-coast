defmodule Constants do
end

defmodule Constants.CLI do
  @commands %{
    "help" => "Prints this help message",
    "level" => "Specify the desired level of the encounters",
    "players" => "Specify the amount of player characters",
    "rocks" => "Specify whether or not to add rock obstacles to the arena",
    "size" => "Specify the desired size of the arena in a WIDTHxHEIGHT format",
    "treasure" => "Specify whether or not to print the treasure table"
  }

  def help do
    """
    Arena Generator is a simple arena generator for D&D.

    #{usage()}

    #{for {command, description} <- @commands, do: "  --#{command}: #{description}\n"}
    """
  end

  def invalid_argument do
    """
    garena: invalid argument. See 'garena --help'. 
    #{usage()}
    """
  end

  def invalid_size do
    "garena: invalid size. Format must be WIDTHxHEIGHT."
  end

  defp usage do
    "usage: garena [--help] [-lvl | --level[=]<int>] [-p | --players[=]<int>] 
    [-r | --rocks] [-s | --size[=]<int>x<int>] [-t | --treasure]"
  end
end
