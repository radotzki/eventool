class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |exception|
    render json: {:alert => exception.message}, status: :forbidden
  end

   private

    def restrict_access
      token = request.headers["token"]
      user = token && User.find_by_authentication_token(token.to_s)
      if user
        sign_in user, store: false
      else
        render json: {}, status: :unauthorized
      end
    end

end
