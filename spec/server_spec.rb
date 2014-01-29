# spec/server_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe "linear equation response " do
  let(:headers) { { "CONTENT_TYPE" => "application/json" } } 
  let(:url) { '/solve'}

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

  it 'should return divide by zero error' do
    body = { equation: { type: "linear", a: "0", b: "0" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Divide by zero!")
  end

  it 'should return wrong equation type error' do
    body = { equation: { type: "wrongtype", a: "0", b: "0" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Wrong type of equation!")
  end

  it 'should return wrong parametrs error' do
    body = { equation: { type: "linear", a: "", b: "0" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Wrong params!")
  end

  it 'should return wrong params error' do
    body = { equation: { type: "linear", a: "0", b: "" } }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Wrong params!")
  end

  it 'should return wrong params error' do
    body = { equation: { type: "linear", a: "23"} }.to_json
    post(url, body, headers)
    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body["error"]).to eq("Wrong number of arguments!")
  end

end