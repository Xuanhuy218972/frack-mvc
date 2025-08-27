
class LoggerMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, body = @app.call(env)
    duration = Time.now - start_time
    method = env["REQUEST_METHOD"]
    path = env["PATH_INFO"]
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    puts "Timestamp: #{timestamp}, Method: #{method}, Path: #{path}, Status: #{status}, Duration: #{duration.round(4)}s"
    
    [status, headers, body]
  end
end
