require 'byebug'
class AuthMiddleware  
  def initialize(app)
    @app = app
  end

  def call(env)
    auth_header = env["HTTP_AUTHORIZATION"]
    if auth_header.nil? || !valid_token?(auth_header)
      return [401, {}, ["Unauthorized"]]
    end

     @app.call(env)
  end
    
  private

  def valid_token?(auth_header)
      if auth_header.start_with?("Bearer ")
        token = auth_header.split(" ").last
        return token == ENV['AUTH_TOKEN']
      end
  
      false
  end
end