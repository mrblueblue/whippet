defmodule Chart.Pie do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  def is_valid selector do
    element_displayed?({:css, "#{selector} g.pie-slice"})

    find_all_elements(:css, "#{selector} g.pie-slice")
      |> Stream.with_index
      |> Enum.all?(&slice_valid?/1)
  end

  defp slice_valid? element_with_index do
    {element, index} = element_with_index
    attribute_value(element, "class") == "pie-slice _#{index}"
  end
end
