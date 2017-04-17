defmodule Chart.Choropleth do
  use Hound.Helpers
  import Beagle.Helpers

  def filter(selector, meta) do
    click find_element(:css, "#{selector} .metaData.#{meta}")
  end
end
