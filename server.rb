require 'sinatra'
require 'json'
require './equations.rb'

# POST '/SOLVE'
post '/solve' do
  content_type :json
  if request.body != nil || request.body.respond_to?(:read)  
    json = JSON.parse(body_request_read(request))
    data = json['equation']
    response = {}
    case data['type']
    when 'linear'
      if data['a'] && data['b']
        if data['a'].empty? || data['b'].empty?
          response[:error] = 'Wrong params!'
        else    
          case results = LinearEquation.new(data['a'], data['b']).solve
          when 'Divide by zero!'
            response[:error] = results
          else
            response[:success] = results
          end
        end
      else
        response[:error] = 'Wrong number of arguments!'
      end

    when 'quadratic'
      if data['a'] && data['b'] && data['c']
        if data['a'].empty? || data['b'].empty? || data['c'].empty?
          response[:error] = 'Wrong params!'
        else
          case results = QuadraticEquation.new(data['a'], data['b'], data['c']).solve
          when 'Divide by zero!'
            response[:error] = results
          else
            response[:success] = results
          end
        end
      else
        response[:error] = 'Wrong number of arguments!'
      end

    else
      response[:error] = 'Wrong type of equation!'
    end

    response.to_json # send json response
  end
end

private
  
def body_request_read(request)
  begin
    request.body.read
  rescue 
    raise "Bad request"
  end
end