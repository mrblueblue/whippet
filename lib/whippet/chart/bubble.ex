defmodule Whippet.Chart.Bubble do
  use Hound.Helpers
  import Beagle.Helpers

  def is_valid anchor do
    element_displayed?({:css, "#{anchor} circle.bubble"})
    find_all_elements(:css, "#{anchor} circle.bubble")
    |> Stream.with_index
    |> Enum.all?(&bubble_class_valid?/1)
  end

  defp bubble_class_valid? {element, index} do
    attribute_value(element, "class") == "bubble _#{index}"
  end

  def num_bubbles selector do
    length find_all_elements(:css, "#{selector} circle.bubble")
  end

  def filter(selector, index) do
    click find_element(:css, "#{selector} circle.bubble._#{index}")
    wait_until_not_visible(".chart-overlay")
    :timer.sleep(Application.get_env(:beagle, :animation_timeout) * 2)
  end

  def bubbles_selected(selector) do
    Whippet.Chart.Helpers.elements_selected(selector, "g.node")
  end

  def is_selected_at(selector, index) do
    bubble = "g.chart-body > g.node:nth-child(#{index + 1})"
    Whippet.Chart.Helpers.is_element_selected_at(selector, bubble)
  end
end
