require 'test_helper'

class TwitterInterfaceTest < ActiveSupport::TestCase

  def test_update
    tweet = 'test tweet'
    TwitterInterface.update(tweet)
    assert_equal TwitterInterface.instance.last_tweet, tweet
  end
end
