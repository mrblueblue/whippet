defmodule Chart.Histogram do
  use ExUnit.CaseTemplate
  use Hound.Helpers

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
end
