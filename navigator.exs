defmodule Navigator do
  use Hound.Helpers

  def logout do
    click({:css, "button.disconnect"})
  end

  def login config do
    click({:css, "div.login-settings-toggle"})

    input = find_element(:css, "#host-field")
    input |> clear_field
    input |> input_into_field(config.host)

    input = find_element(:css, "#port-field")
    input |> clear_field
    input |> input_into_field(config.port)

    input = find_element(:css, "#password")
    input |> input_into_field(Application.get_env(:beagle, :password))

    click({:css, "#connect-button"})
  end

  def dashboard name do
    input = find_element(:css, ".search-input-comp input")
    input |> input_into_field(name)
    click({:css, ".table-body > div > div.row-item > div.cell"})
    :timer.sleep(Application.get_env(:beagle, :animation_timeout) * 2)
  end
end
