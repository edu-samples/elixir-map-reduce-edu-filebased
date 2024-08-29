#!/bin/bash

# Compile the Elixir project
mix compile

# Run the Elixir application
elixir -e "Application.put_env(:map_reduce, :max_workers, 3); MapReduce.start(:normal, []); MapReduce.FileScanner.handle_call({:scan, \"scripts\"}, self(), %{}); :timer.sleep(5000); results = GenServer.call(MapReduce.ResultCollector, :get_results); File.write!(\"output.log\", Enum.join(results)); System.halt(0)"
