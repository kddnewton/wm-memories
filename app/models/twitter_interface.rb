# typed: true
# frozen_string_literal: true

class TwitterInterface
  class Local
    attr_accessor :last_tweet

    # fake the update method and log the tweet
    def update(tweet)
      self.last_tweet = tweet
    end
  end

  class Remote
    delegate :update, to: :client
    attr_accessor :client

    def initialize
      self.client =
        Twitter::REST::Client.new do |config|
          config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
          config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
          config.access_token = ENV['TWITTER_ACCESS_TOKEN']
          config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
        end
    end
  end

  class << self
    delegate :update, to: :instance

    def instance
      @instance ||= Rails.env.production? ? Remote.new : Local.new
    end
  end
end
