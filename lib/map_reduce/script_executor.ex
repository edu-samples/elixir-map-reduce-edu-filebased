defmodule MapReduce.ScriptExecutor do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
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
