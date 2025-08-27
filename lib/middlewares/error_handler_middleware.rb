class ErrorHandlerMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
      [500, { "Content-Type" => "text/plain" }, ["Internal Server Error"]]
    end
  end
end