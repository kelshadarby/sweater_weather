class Api::V1::RoadTripController < ApplicationController
  def show
    render json: RoadTripSerializer.new(road_trip_facade)
  end

  private

  def road_trip_facade
    RoadTripFacade.new(params[:road_trip][:origin], params[:road_trip][:destination])
  end
end
