defmodule Chart.Raster do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  def is_valid(selector, legend) do
    displayed = element_displayed?({:css, "#{selector}.mapboxgl-map"})
    legend_valid = Legend.Ordinal.is_valid(selector, legend)
    displayed && legend_valid
  end
end
