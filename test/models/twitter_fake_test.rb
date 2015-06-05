require 'test_helper'

class TwitterFakeTest < ActiveSupport::TestCase

  def test_update
    tweet = 'test tweet'
    TwitterFake.new.update(tweet)
    assert_equal TwitterFake.last_tweet, tweet
  end

end
