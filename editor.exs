defmodule Editor do
  use Hound.Helpers

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
    end
  end

  defmodule Settings do
    def num_groups num do
      input =
        find_element(:css, ".chart-editor-right-panel")
        |> find_within_element(:css, ".endInput")

      input |> clear_field
      input |> input_into_field(num)

      send_keys(:enter)
      :timer.sleep(Application.get_env(:beagle, :animation_timeout))
    end
  end

  defmodule Dimensions do
    def add({%Selector{value: value}, index}) do
      dimension = find_element(:css, ".dimensions-container>div:nth-child(#{index + 1})")

      dimension
      |> click

      dimension
      |> find_within_element(:css, ".autocomplete-input input")
      |> input_into_field(value)

      send_keys(:enter)
      click({:css, ".chart-editor-left-panel > .chart-editor-label"})
      click({:css, ".chart-editor-left-panel > .chart-editor-label"})
      :timer.sleep(Application.get_env(:beagle, :animation_timeout))
    end
  end

  defmodule Measures do
    def add({selector, index}) do
      case selector do
        %Selector{value: value} ->
          measure = find_element(:css, ".measures-container>div:nth-child(#{index + 1})")

          measure
          |> click

          measure
          |> find_within_element(:css, ".autocomplete-input input")
          |> input_into_field(value)

          send_keys(:enter)
          send_keys(:enter)
          :timer.sleep(Application.get_env(:beagle, :animation_timeout))
        nil -> nil
      end
    end
  end

end
