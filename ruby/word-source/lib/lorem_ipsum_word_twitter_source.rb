require "twitter"
require_relative "lorem_ipsum_word_source"

class LoremIpsumWordTwitterSource < LoremIpsumWordSource
  def initialize(args)
    super(
      :word_source => user_tweets(args.fetch(:username))
    )
  end

  private

  def user_tweets(username)
    twitter_client.user_timeline(username)
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end
  end
end
