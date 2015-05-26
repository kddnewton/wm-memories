class TwitterFake

  cattr_accessor :last_tweet

  def update(tweet)
    self.class.last_tweet = tweet
  end

end
