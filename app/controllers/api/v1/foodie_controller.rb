class Api::V1::FoodieController < ApplicationController
  def show
    render json: FoodieSerializer.new(get_foodie_facade)
  end

  private

  def get_foodie_facade
    foodie_service = FoodieService.new(params[:start], params[:end], params[:search])
    foodie_service.get_restaurant_object
  end
end
