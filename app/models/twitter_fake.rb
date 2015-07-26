class TwitterFake

  cattr_accessor :last_tweet

  # fake the update method and log the tweet
  def update(tweet)
    self.class.last_tweet = tweet
  end
end
