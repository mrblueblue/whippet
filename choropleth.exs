defmodule Chart.Choropleth do
  use Hound.Helpers
  import Beagle.Helpers

  def filter(node, meta) do
    click find_element(:css, "#{node} .metaData.#{meta}")
  end

  def is_selected_at(node, meta) do
    Chart.Helpers.is_element_selected_at(node, ".metaData.#{meta}")
  end
end
