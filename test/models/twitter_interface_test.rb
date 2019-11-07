# typed: false
# frozen_string_literal: true

require 'test_helper'

class TwitterInterfaceTest < ActiveSupport::TestCase
  class FakeClient
    attr_accessor :consumer_key, :consumer_secret, :access_token,
                  :access_token_secret

    def initialize
      yield self
    end

    def update(*); end
  end

  def test_update
    tweet = 'test tweet'
    TwitterInterface.update(tweet)
    assert_equal TwitterInterface.instance.last_tweet, tweet
  end

  def test_interface_prod
    switch_client_constant do
      remote = TwitterInterface::Remote.new
      assert_kind_of FakeClient, remote.client

      remote.update('test tweet')
    end
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
end
