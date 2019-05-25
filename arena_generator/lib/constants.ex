defmodule Constants do
end

defmodule Constants.CLI do
  @commands %{
    "help" => "Prints this help message",
    "level" => "Specify the desired level of the encounter or of the merchant table",
    "merchant" => "Spawn a merchant table file",
    "players" => "Specify the amount of player characters",
    "rocks" => "Specify whether or not to add rock obstacles to the arena",
    "size" => "Specify the desired size of the arena in a WIDTHxHEIGHT format",
    "treasure" => "Specify whether or not to print the treasure table"
  }

  @usage "usage: garena [--help] [-l | --level[=]<int>] [-m | --merchant] 
  [-p | --players[=]<int>] [-r | --rocks] [-s | --size[=]<int>x<int>] [-t | --treasure]"

  def help do
    """
    Arena Generator is a simple arena generator for D&D.

    #{@usage}

    #{for {command, description} <- @commands, do: "\t--#{command}: #{description}\n"}
    """
  end

  def invalid_argument do
    """
    garena: invalid argument. See 'garena --help'. 

    #{@usage}
    """
  end

  def invalid_size do
    """
    garena: invalid size. Format must be WIDTHxHEIGHT.

    #{@usage}
    """
  end
end

defmodule Constants.Merchant do
  @names [
    "Archimed",
    "Balthazar",
    "Divrash",
    "Feihman",
    "Helivri",
    "Malreth",
    "Masso",
    "Nihled",
    "Tondijir",
    "Yalra",
    "Zober"
  ]

  def random_name, do: Enum.random(@names)
end
