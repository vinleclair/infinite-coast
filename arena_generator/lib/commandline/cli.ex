defmodule ArenaGenerator.CLI do
  @moduledoc """
  CLI module for the arena generator
  """

  @doc """
    Parses the command-line arguments and calls the arena generator
  """
  @spec main(String.t()) :: String.t()
  def main(args) do
    {opts,_,invalid}= OptionParser.parse(args, strict: [help: :count, size: :string], aliases: [s: :size])

    cond do 
      length(invalid) > 0 ->
        print_and_exit(invalid)
        System.halt(1)
      List.first(opts) == nil or opts[:help] > 1 ->
        print_help()
    end
  end

  defp print_and_exit(invalid) do
    IO.puts """
    garena: invalid argument --'#{invalid |> List.first |> elem(0) |> String.trim_leading("--")}'.
    usage: garena [--help] [-s | --size <W>x<H>]
    """
  end

  defp print_help() do
    IO.puts """
    Arena Generator is a simple arena generator for D&D.

    usage: garena [--help] [-s | --size <W>x<H>]

      --size: Specify the desired size of the arena in a WidthxHeight format.
              If a single integer is given, defaults to a square. 
              If no integer is given, defaults to 12x12.
      --help: Prints this help message.
    """
  end

  # TODO: Parse size argument
  #defp parse_size(size) do
  #end
end

