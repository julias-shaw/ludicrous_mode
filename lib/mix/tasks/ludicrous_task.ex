defmodule Mix.Tasks.Ludicrous do
  use Mix.Task

  @commit_message Application.get_env(:ludicrous, :commit_message, "Ludicrous mode commit!")
  @domain Application.get_env(:ludicrous, :domain, "github.com")

  @shortdoc "Ludicrous mode commits and pushes automatically."
  def run(_) do
    IO.puts "Ludicrous Mode Engaged!"
    System.cmd("git", ["add", "-A"])
    IO.puts "Committing with message #{@commit_message}"
    System.cmd("git", ["commit", "-m", @commit_message])
    IO.puts "Checking remote repo (#{@domain}) availability..."
    {_, result_code } = System.cmd("ping", ["-c", "1", "-q", @domain])
    case result_code do
      0 ->
        IO.puts "Pushing to remote repo"
        System.cmd("git", ["push", "origin", "master"])
      _ ->
        IO.puts("Network not available - Not pushing :(")
    end
  end
end
