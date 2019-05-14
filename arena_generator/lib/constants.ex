defmodule Constants do

end

defmodule Constants.CLI do
  @commands %{
    "help" => "Prints this help message.",
    "size" => "Specify the desired size of the arena in a WIDTHxHEIGHT format."
  }

  def help do
    """
    Arena Generator is a simple arena generator for D&D.

    usage: garena [--help] [-s | --size[=]<W>x<H>]

    #{for {command, description} <- @commands, do: "  --#{command}: #{description}\n"}
    """
  end

  def invalid_argument(invalid) do
    """
    garena: invalid argument '#{invalid |> List.first |> elem(0) }'.
    usage: garena [--help] [-s | --size <W>x<H>]
    """
  end

  def invalid_size do
    "garena: invalid size. Format must be WIDTHxHEIGHT (<int>x<int>)."
  end

  def overload do
    "garena: flag overload. See 'garena --help'."
  end
end
