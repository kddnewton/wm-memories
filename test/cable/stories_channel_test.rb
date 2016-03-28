require 'test_helper'

class StoriesChannelTest < ActiveSupport::TestCase
  class ConnectionStub
    attr_accessor :identifiers, :subscriptions

    def initialize
      self.identifiers = []
      self.subscriptions = []
    end

    def pubsub
      self
    end

    def subscribe(*args)
      self.subscriptions << args
    end
  end

  def test_subscribed
    connection = ConnectionStub.new
    channel = StoriesChannel.new(connection, '')

    run_in_event_loop do
      channel.subscribed
    end

    assert_equal ['stories'], connection.subscriptions.map(&:first).uniq
  end
end
