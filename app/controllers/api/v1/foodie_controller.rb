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
    json = ForecastSerializer.new(get_forecast_object).serialized_json
    parsed = JSON.parse(json, symbolize_names: true)

    forecast_temp = parsed[:data][:attributes][:actual_temp]
    forecast_description = parsed[:data][:attributes][:weather_description]

    # Geocode Lat Lon
    # obj = (GeocodingService.new).get_geocode_objects(params[:end])
    # lat = obj.latitude
    # lng = obj.longitude
    #
    # # Zomato API
    # zomato_response = Faraday.get("https://developers.zomato.com/api/v2.1/search") do |f|
    #   f.headers[:user_key] = ENV["ZOMATO_API_KEY"]
    #   f.params[:lat] = lat
    #   f.params[:lon] = lng
    #   f.params[:q] = params[:search]
    # end
    #
    # parsed_zomato_response = JSON.parse(zomato_response.body, symbolize_names: true)

    name = parsed_zomato_response[:restaurants][0][:restaurant][:name]
    address = parsed_zomato_response[:restaurants][0][:restaurant][:location][:address]
  end

  private

  def get_forecast_object
    forecast_service = ForecastService.new(params[:end])
    forecast_service.get_forecast_objects
  end
end
