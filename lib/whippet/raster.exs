defmodule Whippet.Chart.Raster do
  use Hound.Helpers

  def is_valid(selector, spec) do
    displayed = canvas_displayed?(selector, spec.use_map)

    if spec.legend do
      legend_valid = Legend.Ordinal.is_valid(selector, spec.legend)
      displayed && legend_valid
    else
      displayed
    end
  end

  def canvas_displayed?(selector, use_map) do
    if use_map do
      element_displayed?({:css, "#{selector}.mapboxgl-map"})
    else
      element_displayed?({:css, "#{selector} canvas.webgl-canvas"})
    end
  end
end
