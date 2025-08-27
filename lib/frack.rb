$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'rack'
require 'tilt'
require 'erb'
require 'active_record'
require 'pg'
require 'bcrypt'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  host:     'localhost',
  database: 'frack_mvc',
  username: 'userform', 
  password: 'Xuanhuy21@nba' 
)

module Frack
    autoload :Router, 'frack/router'
    autoload :Application, 'frack/application'
    autoload :BaseController, 'frack/base_controller'
end