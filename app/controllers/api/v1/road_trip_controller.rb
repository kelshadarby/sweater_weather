class Api::V1::RoadTripController < ApplicationController
  def show
    user = User.find_by(api_key: params[:road_trip][:api_key])
    if user
      render json: RoadTripSerializer.new(road_trip_facade)
    elsif !(params[:road_trip][:api_key])
      render json: { errors: "API Key is Required" }, status: 401
    else
      render json: { errors: "Invalid API Key" }, status: 401
    end
  end

  private

  def road_trip_facade
    RoadTripFacade.new(params[:road_trip][:origin], params[:road_trip][:destination])
  end
end
