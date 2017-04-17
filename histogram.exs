defmodule Chart.Histogram do
  use Hound.Helpers
  import Beagle.Helpers

  def is_valid selector do
    num_bars(selector) > 1 && axis_rendered?(selector)
  end

  def num_bars selector do
    length find_all_elements(:css, "#{selector} .chart-body rect.bar")
  end

  defp axis_rendered? selector do
    element_displayed?({:css, "#{selector} .axis.x"})
    element_displayed?({:css, "#{selector} .axis.y"})
  end

  def brush(selector, [brush_start, brush_end]) do
    move_to({:css, "#{selector} .brush"}, brush_start, 50)
    mouse_down()
    move_to({:css, "#{selector} .brush"}, brush_end, 50)
    mouse_up()
    wait_until_not_visible(".chart-overlay")
  end
end
