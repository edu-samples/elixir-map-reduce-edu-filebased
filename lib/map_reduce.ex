defmodule MapReduce do
  use Application

  def start(_type, _args) do
    max_workers = Application.get_env(:map_reduce, :max_workers, 3)

    children = [
      {MapReduce.FileScanner, max_workers},
      {MapReduce.ScriptExecutorSupervisor, max_workers},
      {MapReduce.ResultCollector, []}
    ]

    opts = [strategy: :one_for_one, name: MapReduce.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
