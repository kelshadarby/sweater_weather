class Api::V1::BackgroundImageController < ApplicationController
  def show
    render json: BackgroundImageSerializer.new(get_background_image)
  end

  private

  def get_background_image
    location = params[:location].split(',')[0]
    (BackgroundImageService.new).get_image(location)
  end
end
