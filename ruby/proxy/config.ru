require File.expand_path("../lib/proxy", __FILE__)
require File.expand_path("../lib/http_client", __FILE__)

run Proxy.new(
  :http_client_builder => HTTPClient.method(:new)
)
