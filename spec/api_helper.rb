
  def api_get action, user, production, params={}, version="1"
    post "/api/v1/login", {email: "#{user}@#{production}.com", password: "12345678"}
    json = JSON.parse(response.body)
    
    get "/api/v#{version}/#{action}", params, {'token' => json["auth_token"]}
    JSON.parse(response.body) rescue {}
  end

  def api_post action, user, production, params={}, version="1"
    post "/api/v1/login", {email: "#{user}@#{production}.com", password: "12345678"}
    json = JSON.parse(response.body)    

    post "/api/v#{version}/#{action}", params, {'token' => json["auth_token"]}
    JSON.parse(response.body) rescue {}
  end

  def api_put action, user, production, params={}, version="1"
    post "/api/v1/login", {email: "#{user}@#{production}.com", password: "12345678"}
    json = JSON.parse(response.body)    

    put "/api/v#{version}/#{action}", params, {'token' => json["auth_token"]}
    JSON.parse(response.body) rescue {}
  end

  def api_delete action, user, production, params={}, version="1"
    post "/api/v1/login", {email: "#{user}@#{production}.com", password: "12345678"}
    json = JSON.parse(response.body)    

    delete "/api/v#{version}/#{action}", params, {'token' => json["auth_token"]}
    JSON.parse(response.body) rescue {}
  end