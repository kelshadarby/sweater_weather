class Api::V1::ForecastController < ApplicationController
  def show
    geocode = GeocodingService.new
    geocode_object = geocode.get_geocode_objects(params[:location])

    weather = WeatherService.new
    weather_object = weather.get_weather_objects(geocode_object)

    render json: ForecastSerializer.new(weather_object)
  end
end
