require 'pg'
require 'dotenv/load'

# Database configuration
DB_CONFIG = {
  dbname: ENV['DB_NAME'],
  user: ENV['DB_USER'],
  password: ENV['DB_PASSWORD'],
  host: ENV['DB_HOST'],
  port: ENV['DB_PORT'] || 5432 # Use default port 5432 if not set
}

# Connect to the database
begin
  $conn = PG.connect(DB_CONFIG)
  puts 'Connected to the database'
rescue PG::Error => e
  puts "Unable to connect to the database: #{e.message}"
  exit
end

class MessageService
  def self.add_message(message)
    # Insert the message into the database
    begin
      query = $conn.exec_params('INSERT INTO messages (body) VALUES ($1) RETURNING id', [message])
    rescue PG::Error => e
      raise StandardError, "Error adding message: #{e.message}"
    end

    # Get the ID of the inserted message
    id = query[0]['id']

    # Return the message object
    { id: id, body: message }
  end
end
