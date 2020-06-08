class Api::V1::FoodieController < ApplicationController
  def show
    render json: FoodieSerializer.new(get_foodie_facade)
  end

  private

  def get_foodie_facade
    (FoodieService.new).get_restaurant_object(params[:start], params[:end], params[:search])
  end
end
