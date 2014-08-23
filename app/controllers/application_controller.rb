include ActionController::HttpAuthentication::Token::ControllerMethods
include ActionController::MimeResponds

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  

  rescue_from CanCan::AccessDenied do |exception|
    render json: {:alert => exception.message}, status: :forbidden
  end

   private

    def restrict_access
      authenticate_or_request_with_http_basic do |email, password| 
        found_user = User.find_by_email(email)
        if found_user && found_user.valid_password?(password) && !found_user.lock
          sign_in(found_user)
        end
      end
    end

end
