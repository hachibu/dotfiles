require "http"
require "json"

module DarkSky
  class Forecast
    JSON.mapping(
      latitude: Float64,
      longitude: Float64,
      currently: Currently,
      daily: Daily
    )
  end

  class Currently
    JSON.mapping(
      summary: String,
      temperature: Float64,
      time: Int64
    )
  end

  class Daily
    JSON.mapping(summary: String)
  end
end

class DarkSky::Client
  alias Params = NamedTuple

  Host = "https://api.darksky.net"

  def initialize(@auth_token : String)
  end

  def forecast(latitude : Float64, longitude : Float64) : Forecast
    response = get(
      join_host("forecast", @auth_token, "#{latitude},#{longitude}"),
      { exclude: "minutely,hourly,alerts,flags" }
    )
    Forecast.from_json(response)
  end

  def get(url : String, params : Params? = nil) : String
    unless params.nil?
      url += "?#{HTTP::Params.encode(params)}"
    end
    `curl --silent #{url}`
  end

  def join_host(*args : _) : String
    File.join(Host, *args)
  end
end
