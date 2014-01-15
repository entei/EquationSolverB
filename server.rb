require 'sinatra'
require 'json'
require './equations.rb'

# POST METHOD
post '/solve' do
  content_type :json
  if request.body != nil && request.body.respond_to?(:read)
    body = body_request_read(request)    
    data = JSON.parse(body)
    
    case data['type']
    when 'linear'
      if data["a"] != nil && data["b"] != nil
        result = LinearEquation.new(data["a"], data["b"]).solve
        response = { "Success" => result }.to_json #send json result
      else
        response = { "Error" => "Wrong params" }
      end
    when 'quadratic'
      if data["a"] != nil && data["b"] != nil && data["c"] != nil
        result = QuadraticEquation.new(data["a"], data["b"], data["c"]).solve
        answer = { "Success" => result }.to_json #send json result
      else
        response = { "Error" => "Wrong params" }
      end
    end
  end
end

private

def body_request_read(request)
  begin
    request.body.read
  rescue
    nil
  end
end