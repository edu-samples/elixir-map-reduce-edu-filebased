defmodule MapReduce.ResultCollector do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, %{results: []}}
  end

  def handle_cast({:collect, file, result}, state) do
    timestamp = NaiveDateTime.local_now() |> NaiveDateTime.to_string()
    formatted_result = "# #{timestamp} #{file}\n`````````\n#{result}\n`````````\n\n"
    updated_results = [formatted_result | state.results]
    {:noreply, %{state | results: updated_results}}
  end

  def handle_call(:get_results, _from, state) do
    {:reply, Enum.reverse(state.results), state}
  end
end
