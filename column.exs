defmodule Column do
  @strings [
    "dest_state",
    "dest_city",
    "carrier_name",
    "origin_city"
  ]

  @ints [
    "arrdelay",
    "airtime",
    "depdelay",
    "carrierdelay",
    "distance"
  ]

  @records [
    "# Records"
  ]

  def random types do
    types
    |> Enum.reduce([], &add_columns_by_type/2)
    |> Enum.random
  end

  defp add_columns_by_type(type, acc) do
    case type do
      :string -> Enum.concat(acc, @strings)
      :int -> Enum.concat(acc, @ints)
      :records -> Enum.concat(acc, @records)
      _ -> acc
    end
  end
end
