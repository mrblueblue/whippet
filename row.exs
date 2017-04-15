defmodule Chart.Row do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  def is_valid selector do
    element_displayed?({:css, "#{selector} g.row"})

    find_all_elements(:css, "#{selector} g.row")
      |> Stream.with_index
      |> Enum.all?(&row_class_valid?/1)
  end

  defp row_class_valid? element_with_index do
    {element, index} = element_with_index
    attribute_value(element, "class") == "row _#{index}"
  end
end
