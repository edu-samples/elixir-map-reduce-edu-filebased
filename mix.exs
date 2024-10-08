defmodule MapReduce.MixProject do
  use Mix.Project

  def project do
    [
      app: :map_reduce,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :poolboy],
      mod: {MapReduce, []}
    ]
  end

  defp deps do
    [
      {:poolboy, "~> 1.5"}
    ]
  end
end
