require 'sinatra'
require 'json'
require './equations.rb'

# POST METHOD
post '/solve' do
  content_type :json
  if request.body != nil || request.body.respond_to?(:read)
    body = body_request_read(request)    
    data = JSON.parse(body)
    
    response = {}
    case data['type']
    when 'linear'
      if data["a"].empty? || data["b"].empty?
        response["Error"] = "Wrong params!"
      else
        results = LinearEquation.new(data["a"].to_f, data["b"].to_f).solve
        response["Success"] = results.all? { |x| x.finite? } ? results : ["Divide by zero!"]
      end

    when 'quadratic'
      if data["a"].empty? || data["b"].empty? || data["c"].empty?
        response["Error"] = "Wrong params!"
      else
        if data["a"].to_f != 0
          results = QuadraticEquation.new(data["a"].to_f, data["b"].to_f, data["c"].to_f).solve
        else
          results = LinearEquation.new(data["b"].to_f, data["c"].to_f).solve
        end
        response["Success"] = results.all? { |x| !x.real? || x.finite? } ? results : ["Divide by zero!"]
      end

    else
      response["Error"] = "Wrong type of equation!"
    end

    response.to_json # send json response
  end
end

private

def body_request_read(request)
  begin
    request.body.read
  rescue 
    p "Bad request"
  end
end