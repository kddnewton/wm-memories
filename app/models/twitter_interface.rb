# typed: strict
# frozen_string_literal: true

class TwitterInterface
  class Local
    extend T::Sig

    sig { returns(T.nilable(String)) }
    attr_reader :last_tweet

    sig { void }
    def initialize
      @last_tweet = T.let(nil, T.nilable(String))
    end

    # fake the update method and log the tweet
    sig { params(tweet: String).returns(String) }
    def update(tweet)
      @last_tweet = tweet
    end
  end

  class Remote
    extend T::Sig

    sig { returns(T.nilable(String)) }
    attr_reader :last_tweet

    sig { returns(Twitter::REST::Client) }
    attr_reader :client

    sig { void }
    def initialize
      @last_tweet = T.let(nil, T.nilable(String))
      @client =
        T.let(
          Twitter::REST::Client.new do |config|
            config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
            config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
            config.access_token = ENV['TWITTER_ACCESS_TOKEN']
            config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
          end,
          Twitter::REST::Client
        )
    end

    sig { params(tweet: String).returns(String) }
    def update(tweet)
      client.update(tweet)
      @last_tweet = tweet
    end
  end

  class << self
    extend T::Sig

    delegate :update, to: :instance

    sig { returns(T.any(Remote, Local)) }
    attr_reader :instance
  end

  @instance = T.let(Rails.env.production? ? Remote.new : Local.new, T.any(Remote, Local))
end
