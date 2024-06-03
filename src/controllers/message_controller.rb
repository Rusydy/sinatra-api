require_relative '../services/message_service'

class MessageController < Sinatra::Base
  # Create a new message
  post '/add-message' do
    body = request.body.read

    begin
      # Parse the body as JSON
      body = JSON.parse(body)
    rescue JSON::ParserError
      response.body = {
        status: 'error',
        message: 'Request body is not valid JSON'
      }.to_json
      return
    end

    if body.empty?
      response.body = {
        status: 'error',
        message: 'Request body is empty'
      }.to_json
      return
    end

    if body["message"] == nil || body["message"] == ''
      response.body = {
        status: 'error',
        message: 'message field is empty'
      }.to_json
      return
    end

    # call the service to add the message
    begin
      message = MessageService.add_message(body["message"])
    rescue StandardError => e
      response.body = {
        status: 'error',
        message: e.message
      }.to_json
      return
    end

    response.body = {
      status: 'ok',
      message: {
        id: message.id,
        message: message.body,
      }
    }.to_json
  end
end
