defmodule Column do

  @columns %{
    "flights" => %{
      string: [
        "dest_state",
        "dest_city",
        "carrier_name",
        "origin_city"
      ],
      int: [
        "arrdelay",
        "airtime",
        "depdelay",
        "carrierdelay",
        "distance"
      ],
      lon: "dest_lon",
      lat: "dest_lat"
    },
    "contributions" => %{
      string: [
        "recipient_party",
        "committee_name",
        "contributor_gender",
        "organization_name",
        "contributor_state",
        "contributor_zipcode"
      ],
      int: [
        "amount",
        "political_cycle",
        "lon",
        "lat"
      ],
      lon: "lon",
      lat: "lat"
    },
    "tweets" => %{
      string: [
        "country",
        "lang",
      ],
      int: [
        "followers",
        "followees",
        "tweet_count",
        "lon",
        "lat"
      ],
      lon: "lon",
      lat: "lat"
    }
  }

  def lon (table)  do
    @columns[table].lon
  end

  def lat (table) do
    @columns[table].lat
  end

  def random(table, types) do
    types
    |> (&(add_columns(&1, table))).()
    |> Enum.random
  end

  defp add_columns(types, table) do
    Enum.reduce(types, [], fn(type, acc) ->
      case type do
        :int -> Enum.concat(acc, @columns[table][type])
        :string -> Enum.concat(acc, @columns[table][type])
        :records -> Enum.concat(acc, ["# Records"])
        _ -> acc
      end
    end)
  end

end
