# frozen_string_literal: true

class TwitterInterface
  class Local
    attr_reader :last_tweet

    def initialize
      @last_tweet = nil
    end

    # fake the update method and log the tweet
    def update(tweet)
      @last_tweet = tweet
    end
  end

  class Remote
    attr_reader :last_tweet, :client

    def initialize
      @last_tweet = nil
      @client = make_client
    end

    def update(tweet)
      client.update(tweet)
      @last_tweet = tweet
    end

    private

    def make_client
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

    attr_reader :instance
  end

  @instance = Rails.env.production? ? Remote.new : Local.new
end
