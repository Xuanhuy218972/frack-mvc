$LOAD_PATH.unshift << '.'
# require 'rack'
# require 'Tilt'

# module Frack
#   class Application
#     class << self
#       def call(env)
#         if env['PATH_INFO'] == '/'
#           UsersController.new.index
#         else
#           [404, { 'content-type' => 'text/plain' }, ['Not found']]
#         end
#       end
#     end
#   end

#   class BaseController
#     def render(view)
#       render_template('layouts/application') do
#         render_template(view)
#       end
#     end

#     def render_template(path, &block)
#       Tilt.new("app/views/#{path}.html.erb").render(self, &block)
#     end
#   end

#   class UsersController < Frack::BaseController
#     def index
#       @users = User.all
#       body = render('users/index')
#       [200, { 'content-type' => 'text/html' }, [body]]
#     end
#   end

#   class User
#     def self.all
#       ['Anthony Stark', 'Peter Parker', 'Bruce Wayne']
#     end
#   end
# end

# Thay thế toàn bộ nội dung config.ru
require 'lib/frack'
require 'app/controllers/users_controller'
require 'app/controllers/home_controller'
require 'app/controllers/sessions_controller'
require 'app/models/user'
require_relative 'lib/middlewares/logger_middleware'
require 'rack/session/cookie' 

use Rack::Static, root: 'public', urls: ['/images', '/js', '/css']
use LoggerMiddleware

use Frack::Router do 
    get '/sign_up' => 'users#new'
    post '/users/sign_up' => 'users#create'
    post '/sign_in' => 'sessions#create'
    delete '/sign_out' => 'sessions#destroy'
    get '/users' => 'users#index'
    get "/" => 'home#show'
end

use Rack::Session::Cookie, 
    key:'rack.session',
    path: '/',
    secret: 'your_secret_key_0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'

run Frack::Application