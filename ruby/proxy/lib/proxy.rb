require "sinatra/base"

class Proxy < Sinatra::Base
  def initialize(args)
    super
    @http_client_builder = args.fetch(:http_client_builder)
  end

  get %r{^/$|^/hello_world$} do
    http_client.get(request.path).body
  end

  private

  attr_reader :http_client_builder

  def http_client
    @http_client ||= http_client_builder.call({
      :url    => url,
      :params => api_key,
    })
  end

  def url
    "http://localhost:4567/"
  end

  def api_key
    { :api_key => "awesomeserver" }
  end
end
