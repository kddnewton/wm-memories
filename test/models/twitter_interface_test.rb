# frozen_string_literal: true

require 'test_helper'

class TwitterInterfaceTest < ActiveSupport::TestCase
  class FakeClient
    attr_accessor :consumer_key, :consumer_secret, :access_token,
                  :access_token_secret

    def initialize
      yield self
    end
  end

  def test_update
    tweet = 'test tweet'
    TwitterInterface.update(tweet)
    assert_equal TwitterInterface.instance.last_tweet, tweet
  end

  # there has got to be a better way to do this test
  def test_interface_prod
    unset_twitter_instance
    Rails.stub(:env, ActiveSupport::StringInquirer.new('production')) do
      switch_client_constant do
        assert_kind_of FakeClient, TwitterInterface.instance.client
      end
    end
    unset_twitter_instance
  end

  private

  def switch_client_constant
    client = Twitter::REST::Client
    begin
      Twitter::REST.send(:remove_const, :Client)
      Twitter::REST.const_set(:Client, FakeClient)
      yield
    ensure
      Twitter::REST.send(:remove_const, :Client)
      Twitter::REST.const_set(:Client, client)
    end
  end

  def unset_twitter_instance
    TwitterInterface.instance_variable_set(:@instance, nil)
  end
end
