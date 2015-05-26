require 'test_helper'

class TwitterFakeTest < ActiveSupport::TestCase

  def test_update
    tweet = 'test tweet'
    fake = TwitterFake.new
    fake.update(tweet)

    assert_equal TwitterFake.last_tweet, tweet
  end

end
