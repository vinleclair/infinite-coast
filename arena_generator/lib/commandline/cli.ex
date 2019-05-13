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
        print_invalid_argument(invalid)

      List.first(opts) == nil or opts[:help] >= 1 ->
        print_help()
    end
  end

  defp print_invalid_argument(invalid) do
    IO.puts Constants.invalid_argument(invalid)
  end

  defp print_help() do
    IO.puts Constants.help
  end

  # TODO: Parse size argument
  #defp parse_size(size) do
  #end
end

