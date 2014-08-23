class API::V1::SessionsController < ApplicationController

  # before_action :restrict_access, except: :create
  # load_and_authorize_resource except: [:create]
  
  def create
    # authenticate_or_request_with_http_basic do |email, password| 
    found_user = User.find_by_email(params[:email])
    if found_user && found_user.valid_password?(params[:password]) && !found_user.lock
      sign_in(found_user)
      render json: {}, status: :ok
    else
      render json: {}, status: :unauthorized
    end
    
  end

  private

  def login_params
    params.permit(:email, :password)
  end 

end
