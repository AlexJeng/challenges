require "faraday"

class HTTPClient
  InvalidResponseError = Class.new(StandardError)

  def initialize(args = {})
    @client = Faraday.new(
      :url    => args.fetch(:url),
      :params => args.fetch(:params, {})
    ) do |conn|
      conn.request :url_encoded
      conn.adapter Faraday.default_adapter
    end
  end

  def get(*args)
    make_request(:get, *args)
  end

  private

  attr_reader :client

  def make_request(verb, *args)
    client.public_send(verb, *args)
  rescue Faraday::Error::ClientError
    raise InvalidResponseError, "Invalid response"
  end
end
