defmodule Editor do
  use Hound.Helpers
  import Beagle.Helpers

  def switch_chart type do
    click({:css, ".#{type}-btn"})
  end

  defmodule Chart do
    def create spec do
      Editor.switch_chart(spec.type)

      spec.dimensions
      |> Stream.with_index
      |> Enum.each(&Editor.Dimensions.add/1)

      spec.measures
      |> Stream.with_index
      |> Enum.each(&Editor.Measures.add/1)

      wait_until_not_visible(".chart-overlay")
      :ok
    end

    def save do
      click({:css, ".button.save"})
      :timer.sleep(Application.get_env(:beagle, :animation_timeout) * 2)
    end
  end

  defmodule Settings do

    def geo_json text do
      input_into_field({:css, ".react-selectize-search-field-and-selected-values input"}, text)
      send_keys(:enter)
      :timer.sleep(Application.get_env(:beagle, :animation_timeout))
    end

    def num_groups num do
      input =
        find_element(:css, ".chart-editor-right-panel")
        |> find_within_element(:css, ".endInput")

      input |> clear_field
      input |> input_into_field(num)

      send_keys(:enter)
      wait_until_not_visible(".chart-overlay")
      :timer.sleep(Application.get_env(:beagle, :animation_timeout))
    end
  end

  defmodule Dimensions do
    def add({%Selector{value: value}, index}) do
      dimension = find_element(:css, ".dimensions-container>div:nth-child(#{index + 1})")

      click dimension

      dimension
      |> find_within_element(:css, ".autocomplete-input input")
      |> input_into_field(value)

      send_keys(:enter)
      send_keys(:enter)
      wait_until_not_visible(".invisible-overlay")
    end
  end

  defmodule Measures do
    def add({selector, index}) do
      case selector do
        %Selector{value: value} ->
          measure = find_element(:css, ".measures-container>div:nth-child(#{index + 1})")

          click measure

          measure
          |> find_within_element(:css, ".autocomplete-input input")
          |> input_into_field(value)

          send_keys(:enter)
          send_keys(:enter)
          Beagle.Helpers.wait_until_not_visible(".invisible-overlay")
        nil -> nil
      end
    end
  end

end
