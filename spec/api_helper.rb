  def api_get action, user, production, params={}, version="1"
    get "/api/v#{version}/#{action}", params, {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("#{user}@#{production}.com","12345678")}
    JSON.parse(response.body) rescue {}
  end

  def api_post action, user, production, params={}, version="1"
    post "/api/v#{version}/#{action}", params, {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("#{user}@#{production}.com","12345678")}
    JSON.parse(response.body) rescue {}
  end

  def api_put action, user, production, params={}, version="1"
    put "/api/v#{version}/#{action}", params, {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("#{user}@#{production}.com","12345678")}
    JSON.parse(response.body) rescue {}
  end

  def api_delete action, user, production, params={}, version="1"
    delete "/api/v#{version}/#{action}", params, {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("#{user}@#{production}.com","12345678")}
    JSON.parse(response.body) rescue {}
  end

