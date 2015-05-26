require 'test_helper'

class TwitterFakeTest < ActiveSupport::TestCase

  def test_update
    fake = TwitterFake.new

    assert_difference('TwitterFake.tweets.length', 1) do
      fake.update('test tweet')
    end
  end

end
