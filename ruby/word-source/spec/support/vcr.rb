require "vcr"

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = "spec/support/cassettes"
  c.filter_sensitive_data("<CONSUMER_KEY>")    { ENV.fetch("CONSUMER_KEY") }
  c.filter_sensitive_data("<CONSUMER_SECRET>") { ENV.fetch("CONSUMER_SECRET") }
  c.filter_sensitive_data("<ACCESS_TOKEN>")    { ENV.fetch("ACCESS_TOKEN") }
  c.filter_sensitive_data("<ACCESS_SECRET>")   { ENV.fetch("ACCESS_SECRET") }
  c.configure_rspec_metadata!
  c.default_cassette_options = { :record => :new_episodes }
end
