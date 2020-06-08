class Api::V1::ForecastController < ApplicationController
  def show
    render json: ForecastSerializer.new(get_forecast_object)
  end

  private

  def get_forecast_object
    forecast_service = ForecastService.new(params[:location])
    forecast_service.get_forecast_objects
  end
end
