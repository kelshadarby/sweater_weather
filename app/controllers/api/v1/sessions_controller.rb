class Api::V1::SessionsController < ApplicationController
  def create
    session[:user] = User.find_by(email: params[:user][:email])
    render json: UsersSerializer.new(session[:user])
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
