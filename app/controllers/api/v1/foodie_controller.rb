class Api::V1::FoodieController < ApplicationController
  def show
    render json: FoodieSerializer.new(foodie_facade)
  end

  private

  def foodie_facade
    foodie_service = FoodieService.new(params[:start], params[:end], params[:search])
    foodie_service.get_foodie_facade
  end
end
