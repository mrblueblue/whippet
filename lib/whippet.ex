defmodule Whippet do
  defmacro __using__([]) do
    quote do
      import Whippet.Chart
      import Whippet.Chart.Bubble
      import Whippet.Chart.Choropleth
      import Whippet.Chart.Count
      import Whippet.Chart.Heatmap
      import Whippet.Chart.Histogram
      import Whippet.Chart.Line
      import Whippet.Chart.Pie
      import Whippet.Chart.Raster
      import Whippet.Chart.Row
      import Whippet.Chart.Table
      import Whippet.Legend
      import unquote(__MODULE__)
    end
  end
end
