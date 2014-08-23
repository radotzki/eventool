class API::V1::SessionsController < ApplicationController

  def create
    user = User.find_for_database_authentication(email: params[:email])
    if user && user.valid_password?(params[:password]) && !user.lock
      token = user.ensure_authentication_token
      render json: {auth_token: token}, status: :ok
    else
      render json: {}, status: :unauthorized
    end
    
  end

  private

  def login_params
    params.permit(:email, :password)
  end 

end
