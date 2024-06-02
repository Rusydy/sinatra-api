class Routes < Sinatra::Base
  # health check api
  get '/health-check' do
    response.body = {
      status: 'ok',
      message: 'I am healthy'
    }.to_json
  end

  # add new message api
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
        message: 'message field is empy'
      }.to_json
      return
    end

    # dummy response
    response.body = {
      status: 'ok',
      message: "Message added successfully; #{body["message"]}",
    }.to_json
  end

end
