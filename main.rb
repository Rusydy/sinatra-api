require 'sinatra'
require 'dotenv/load'
require 'http_status'
require_relative 'src/routes'

set :port, ENV['APP_PORT'] || 8080

use Routes

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
