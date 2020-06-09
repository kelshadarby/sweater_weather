class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user] = user
      render json: UsersSerializer.new(user)
    else
      render json: { error: "Bad credentials. Please double check login request." }, status: 420
    end
  end
end
