defmodule Chart.Table do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  def is_valid selector do
    headers = get_headers(selector)
    rows = get_rows(selector)
    length(rows) > 1 && String.length(headers) > 1
  end

  def get_headers selector do
    visible_text({:css, "#{selector} .md-table-header"})
  end

  def get_rows selector do
    find_all_elements(:css, "#{selector} .table-row")
  end

  def rows_as_text selector do
    visible_text({:css, "#{selector} .md-table-scroll"})
  end

  def sort(selector, index) do
    click({:css, "#{selector} .docked-table-header > div:nth-child(#{index + 1})"})
  end

  def filter(selector, index) do
    click({:css, "#{selector} table > tr:nth-child(#{index + 2})"})
    :timer.sleep(Application.get_env(:beagle, :animation_timeout))
  end

  def is_selected_at(selector, index) do
    Chart.Helpers.is_element_selected_at(selector, "table > tr:nth-child(#{index + 2})")
  end
end
