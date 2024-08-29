defmodule MapReduce.FileScanner do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:scan, directory}, _from, state) do
    files = File.ls!(directory)
    |> Enum.filter(&File.regular?("#{directory}/#{&1}"))
    |> Enum.map(&"#{directory}/#{&1}")

    Enum.each(files, fn file ->
      GenServer.cast(MapReduce.ScriptExecutor, {:execute, file})
    end)

    {:reply, :ok, state}
  end
end
