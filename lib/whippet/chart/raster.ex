defmodule Whippet.Chart.Raster do
  use Hound.Helpers
  import Beagle.Helpers

  def is_valid(selector, spec) do
    displayed = canvas_displayed?(selector, spec.use_map)
    if spec.legend do
      legend_valid = Whippet.Legend.Ordinal.is_valid(selector, spec.legend)
      displayed && legend_valid
    else
      displayed
    end
  end

  def canvas_displayed?(selector, use_map) do
    if use_map do
      element_displayed?({:css, "#{selector}.mapboxgl-map"})
    else
      element_displayed?({:css, "#{selector} canvas.webgl-canvas"})
    end
  end

  def draw_circle(selector, x, y) do
    click find_element(:css, ".mapd-draw-button-circle")
    move_click(selector, x, y)
    :timer.sleep(Application.get_env(:whippet, :animation_timeout) * 2)
  end

  def draw_polyline(selector, points) do
    click find_element(:css, ".mapd-draw-button-polyline")

    points
      |> Enum.each(fn({x, y}) -> move_click(selector, x, y) end)

    points
      |> Enum.take(-1)
      |> Enum.at(0)
      |> (fn({x, y}) -> move_doubleclick(selector, x, y) end).()

    :timer.sleep(Application.get_env(:whippet, :animation_timeout) * 2)
  end

  def draw_lasso(selector, points) do
    click find_element(:css, ".mapd-draw-button-lasso")

    points
      |> Stream.with_index
      |> Enum.to_list
      |> Enum.each(fn({{x, y}, index}) ->
        move_to({:css, "#{selector} canvas"}, x, y)
        cond do
          index == 0 -> mouse_down()
          index == length(points) - 1 -> mouse_up()
          true -> nil
        end
      end)

    :timer.sleep(Application.get_env(:whippet, :animation_timeout) * 2)
  end

  def remove_selection(selector, x, y) do
    move_click(selector, x, y)
    send_keys(:backspace)
    :timer.sleep(Application.get_env(:whippet, :animation_timeout) * 2)
  end

  defp move_click(selector, x, y) do
    move_to({:css, "#{selector} canvas"}, x, y)
    mouse_down()
    mouse_up()
  end

  defp move_doubleclick(selector, x, y) do
    move_to({:css, "#{selector} canvas"}, x, y)
    doubleclick()
  end
end
