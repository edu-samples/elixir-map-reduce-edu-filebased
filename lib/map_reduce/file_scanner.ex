defmodule MapReduce.FileScanner do
  use GenServer

  def start_link(max_workers) do
    GenServer.start_link(__MODULE__, %{max_workers: max_workers}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:scan, directory}, _from, state) do
    files = File.ls!(directory)
    |> Enum.filter(&File.regular?("#{directory}/#{&1}"))
    |> Enum.map(&"#{directory}/#{&1}")

    Enum.each(files, fn file -> 
      :poolboy.transaction(
        :script_executor_pool,
        fn pid -> GenServer.cast(pid, {:execute, file}) end,
        :infinity
      )
    end)

    {:reply, :ok, state}
  end
end
