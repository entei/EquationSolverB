# spec/server_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe 'linear equation solver' do
  let(:headers) { { "CONTENT_TYPE" => "application/json" } } 
  let(:url) { '/solve' }

  it 'should return a success response' do
    body = { equation: { type: "linear", a: "1", b: "2" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
  end

  it 'should return correct result' do
    body = { equation: { type: "linear", a: "1", b: "2" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["success"]).to eq([-2.0])
  end

  it 'use float' do
    body = { equation: { type: "linear", a: "0.5", b: "4" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["success"]).to eq([-8.0])
  end

  it 'divide by zero error' do
    body = { equation: { type: "linear", a: "0", b: "0" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Divide by zero!")
  end

  it 'wrong equation type error' do
    body = { equation: { type: "wrongtype", a: "1", b: "2" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Wrong type of equation!")
  end

  it 'wrong number of arguments' do
    body = { equation: { type: "linear", a: "0" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Wrong number of arguments!")
  end

  it 'divide by zero' do
    body = { equation: { type: "linear", a: "", b: "0" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Divide by zero!")
  end
end

describe 'quadratic equation solver' do
  let(:headers) { { "CONTENT_TYPE" => "application/json" } } 
  let(:url) { '/solve' }

  it 'should return a success response' do
    body = { equation: { type: "quadratic", a: "1", b: "2" , c: "1"} }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
  end

  it 'should return two roots' do
    body = { equation: { type: "quadratic", a: "2", b: "4", c: "0" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["success"]).to eq([-2.0, 0])
  end

  it 'should return one root' do
    body = { equation: { type: "quadratic", a: "1", b: "2", c: "1" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["success"]).to eq([-1.0])
  end

  it 'should return two complex roots' do
    body = { equation: { type: "quadratic", a: "1", b: "4", c: "5" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["success"]).to eq(['-2.0-1.0i', '-2.0+1.0i'])
  end
end