defmodule Chart.Heatmap do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  def is_valid selector do
    displayed = element_displayed?({:css, "#{selector} g.heatmap"})
    has_boxes = num_boxes(selector) > 1

    displayed && has_boxes
  end

  def num_boxes selector do
    length find_all_elements(:css, "#{selector} g.box-group")
  end

  def filter(selector, index) do
    box = "#{selector} g.box-group:nth-child(#{index + 1})"
    click find_element(:css, box)
    Beagle.Helpers.wait_until_not_visible(".chart-overlay")
  end

  def boxes_selected(selector) do
    Chart.Helpers.elements_selected(selector, "g.box-group")
  end

  def is_selected_at(selector, index) do
    Chart.Helpers.is_element_selected_at(selector, "g.box-group:nth-child(#{index + 1})")
  end
end
