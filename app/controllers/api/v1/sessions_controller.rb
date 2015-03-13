class API::V1::SessionsController < ApplicationController
  before_action :restrict_access, except: :create
  
  def show
    render json: current_user, status: :ok
  end

  def create
    user = User.find_for_database_authentication(email: params[:email])
    if user && user.valid_password?(params[:password]) && !user.lock
      token = user.ensure_authentication_token
      render json: {token: token, user: user}, status: :ok
    elsif user && user.valid_password?(params[:password])
      render json: {message: 'Your account is locked, call your producer for confirmation.'}, status: 499
    elsif user
      render json: {message: 'The password you entered is incorrect.'}, status: 499
    else
      render json: {message: 'The email you entered does not belong to any account.'}, status: 499
    end
    
  end

  private

  def login_params
    params.permit(:email, :password)
  end 

end
