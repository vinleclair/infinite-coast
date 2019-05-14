defmodule ArenaGenerator.CLI do
  @moduledoc """
  CLI module for the arena generator
  """

  @doc """
    Parses the command-line arguments and calls the arena generator
  """
  @spec main(String.t()) :: String.t()
  def main(args) do
    {opts, _, invalid} = OptionParser.parse(args, 
      strict: [help: :boolean, size: :string], 
      aliases: [s: :size])
    
    cond do 
      Enum.empty?(invalid) and Enum.empty?(opts) ->
        execute_command([help: true])
      Enum.empty?(invalid) ->
        execute_command(opts)
      true ->
        IO.puts Constants.CLI.invalid_argument(invalid)
    end
  end

  defp execute_command([help: true]), do: IO.puts Constants.CLI.help

  defp execute_command([size: size]) do
    if valid_size?(size) do
      true
    else
      false
    end
  end

  defp execute_command(_), do: IO.puts Constants.CLI.overload

  defp valid_size?(size), do: String.match?(size, ~r/^(\d+)x(\d+)$/)
end

