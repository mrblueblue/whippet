defmodule Whippet.Legend do
  use Hound.Helpers

  # defmodule Continuous do1
  #   def is_valid selector do
  #
  #   end
  # end

  defmodule Ordinal do
    def is_valid(selector, spec) do
      element_displayed?({:css, "#{selector} .dc-legend-header"})
      find_all_elements(:css, "#{selector} .legend-item-text")
        |> Stream.with_index
        |> Enum.all?(&(legend_item_valid(&1, spec)))
    end

    defp legend_item_valid(item, spec) do
      {element, index} = item
      expected = spec |> Enum.at(index) |> elem(1)
      inner_text(element) == expected
    end
  end
end
