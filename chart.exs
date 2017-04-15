defmodule Chart do
  defstruct type: "table", measures: [], dimensions: []

  defmodule Helpers do
    use Hound.Helpers

    defp get_selection_class element do
      element
      |> attribute_value("class")
      |> String.split
      |> Enum.at(-1)
    end

    def elements_selected(node, selector) do
      find_all_elements(:css, "#{node} #{selector}")
      |> Enum.map(&get_selection_class/1)
      |> Stream.with_index
      |> Enum.filter(&(elem(&1,0) == "selected"))
      |> Enum.map(&(elem(&1,1)))
    end

    def is_element_selected_at(node, selector) do
      find_element(:css, "#{node} #{selector}")
      |> (&(get_selection_class(&1))).()
      |> (&(&1 == "selected")).()
    end
  end
end

defmodule Selector do
  defstruct custom: false, value: "", aggtype: nil
end
