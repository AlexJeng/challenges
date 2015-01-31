require "proxy"
require "rack/test"

describe "Proxy" do
  include Rack::Test::Methods

  let(:body) { "body response" }
  let(:response) { double(:response, :body => body) }
  let(:http_client) { double(:http_client, :get => response) }
  let(:http_client_builder) {
    double(:http_client_builder, :call => http_client)
  }

  subject(:app) {
    Proxy.new(
      :http_client_builder => http_client_builder
    )
  }

  it "works from '/' endpoint" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body).to eq(body)
  end

  it "works from '/hello_world' endpoint" do
    get "/hello_world"
    expect(last_response).to be_ok
    expect(last_response.body).to eq(body)
  end

  it "fails from other endpoints" do
    get "/other-endpoint"
    expect(last_response).to_not be_ok
  end
end
