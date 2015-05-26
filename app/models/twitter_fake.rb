class TwitterFake

  def update(tweet)
    self.class.tweets << tweet
  end

  class << self
    def tweets
      @tweets ||= []
    end
  end

end
