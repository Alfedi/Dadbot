defmodule Dadbot.MixProject do
  use Mix.Project

  def project do
    [
      app: :dadbot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Dadbot, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_gram, "~> 0.6.2"},
      {:jason, ">= 1.0.0"},
      {:tesla, "~> 1.2.1"}
    ]
  end
end
