defmodule Whippet.Mixfile do
  use Mix.Project

  def project do
    [
      app: :whippet,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package(),
      description: description(),
      deps: deps(),
      name: "Whippet",
      source_url: "https://github.com/mrblueblue/whippet"
   ]
  end

  def application do
    [extra_applications: [:logger, :hound, :beagle]]
  end

  defp deps do
    [
      {:hound, "~> 1.0"},
      {:beagle, git:, "mrblueblue/beagle.git"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
   """
   Hound bindings for integration testing MapD dc.js charts
   """
 end

 defp package do
   [
     name: :whippet,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Jonathan Huang"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/mrblueblue/whippet"}
   ]
 end
end
