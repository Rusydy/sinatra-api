require 'sinatra'
require 'dotenv/load'
require 'http_status'
require_relative 'src/controllers/dummy_controller'
require_relative 'src/controllers/message_controller'

set :port, ENV['APP_PORT'] || 8080

# list of controllers
use DummyController
use MessageController

# Trap ^C
Signal.trap('INT') {
  puts "\nShutting down..."
  Sinatra::Application.quit!
}

# Trap `Kill `
Signal.trap('TERM') {
  puts "\nShutting down..."
  Sinatra::Application.quit!
}
