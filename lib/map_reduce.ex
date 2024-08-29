defmodule MapReduce do
  use Application

  def start(_type, _args) do
    children = [
      {MapReduce.FileScanner, []},
      {MapReduce.ScriptExecutor, []},
      {MapReduce.ResultCollector, []}
    ]

    opts = [strategy: :one_for_one, name: MapReduce.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
