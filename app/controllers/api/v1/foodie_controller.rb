class Api::V1::FoodieController < ApplicationController
  def show
    trip_response = Faraday.get("https://maps.googleapis.com/maps/api/directions/json") do |f|
      f.params[:origin] = params[:start]
      f.params[:destination] = params[:end]
      f.params[:key] = ENV["GEOCODING_API_KEY"]
    end

    parsed_trip_response = JSON.parse(trip_response.body, symbolize_names: true)
    duration = parsed_trip_response[:routes][0][:legs][0][:duration][:text]

    # Forecast Data
    forecast_service = ForecastService.new(params[:end])
    obj = forecast_service.get_forecast_objects
    json = ForecastSerializer.new(get_forecast_object).to_


    require "pry"; binding.pry
    obj[:current]

  end
end
