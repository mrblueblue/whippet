defmodule Chart do
  defstruct type: "table", measures: [], dimensions: []
end

defmodule Selector do
  defstruct custom: false, value: "", aggtype: nil
end
