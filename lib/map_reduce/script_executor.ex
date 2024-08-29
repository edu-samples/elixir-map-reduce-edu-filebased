defmodule MapReduce.ScriptExecutor do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: :undefined)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:execute, file}, state) do
    result = System.cmd("bash", [file])
    GenServer.cast(MapReduce.ResultCollector, {:collect, file, result})
    {:noreply, state}
  end
end
defmodule MapReduce.ScriptExecutorSupervisor do
  use Supervisor

  def start_link(max_workers) do
    Supervisor.start_link(__MODULE__, max_workers, name: __MODULE__)
  end

  def init(max_workers) do
    poolboy_config = [
      {:name, {:local, :script_executor_pool}},
      {:worker_module, MapReduce.ScriptExecutor},
      {:size, max_workers},
      {:max_overflow, 0}
    ]

    children = [
      :poolboy.child_spec(:script_executor_pool, poolboy_config, [])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
defmodule MapReduce.ScriptExecutorSupervisor do
  use Supervisor

  def start_link(max_workers) do
    Supervisor.start_link(__MODULE__, max_workers, name: __MODULE__)
  end

  def init(max_workers) do
    poolboy_config = [
      {:name, {:local, :script_executor_pool}},
      {:worker_module, MapReduce.ScriptExecutor},
      {:size, max_workers},
      {:max_overflow, 0}
    ]

    children = [
      :poolboy.child_spec(:script_executor_pool, poolboy_config, [])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
