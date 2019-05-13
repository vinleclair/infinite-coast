defmodule Constants do
  def help do
    """
    Arena Generator is a simple arena generator for D&D.

    usage: garena [--help] [-s | --size <W>x<H>]

      --size: Specify the desired size of the arena in a WidthxHeight format.
              If a single integer is given, defaults to a square. 
              If no integer is given, defaults to 12x12.
      --help: Prints this help message.
    """
  end

  def invalid_argument(invalid) do
    """
    garena: invalid argument '#{invalid |> List.first |> elem(0) }'.
    usage: garena [--help] [-s | --size <W>x<H>]
    """
  end
end

