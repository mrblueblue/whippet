defmodule Filter do
  use Hound.Helpers
  import Beagle.Helpers

  defstruct type: "STR",
    index: 0,
    column: "",
    predicate: "contains",
    value: ""

  def add filter do
    click find_element(:css, ".sql-filters-container>div:nth-child(#{filter.index + 1}")

    input = find_element(:css, ".react-selectize-search-field-and-selected-values input")
    input |> input_into_field(filter.column)
    send_keys(:enter)

    click find_element(:css, ".filter-operators-dropdown")
    :timer.sleep(Application.get_env(:beagle, :animation_timeout))
    move_to({:css, ".table-title"}, 0, 0)
    # send_down_arrow_x_times(:rand.uniform(6))
    click find_element(:css, ".custom-selector-popup > div:nth-child(#{:random.uniform(6)})")
    :timer.sleep(Application.get_env(:beagle, :animation_timeout))
    send_keys(:enter)

    value = find_element(:css, ".filter-value")

    if attribute_value(value, "class") != "filter-value no-input" do
      click find_element(:css, ".filter-value")
      :timer.sleep(Application.get_env(:beagle, :animation_timeout))
      send_down_arrow_x_times(:rand.uniform(10))
      send_keys(:enter)
    end

    click(find_element(:css, ".table-title"))
    :timer.sleep(Application.get_env(:beagle, :animation_timeout))
  end

  def num_filters do
    visible_text({:css, ".filter-number"})
    |> String.to_integer
  end

  def open_filter_panel do
    click find_element(:css, ".left-wrapper > button")
    :timer.sleep(Application.get_env(:beagle, :animation_timeout))
  end

  defp send_down_arrow_x_times (num \\ :rand.uniform(10)) do
    case num do
      0 -> nil
      _ ->
        send_keys(:down_arrow)
        send_down_arrow_x_times(num - 1)
    end
  end

end
