class Api::V1::ForecastController < ApplicationController
  def show
    render json: ForecastSerializer.new(get_forecast_object)
  end

  private

  def get_forecast_object
    (ForecastService.new).get_forecast_objects(get_geocode_object)
  end

  def get_geocode_object
    (GeocodingService.new).get_geocode_objects(params[:location])
  end
end
