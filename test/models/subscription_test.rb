require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  def test_email_presence_validation
    subscription = Subscription.new
    assert_not subscription.save
    assert_not subscription.errors[:email].blank?
  end

  def test_email_uniqueness_validation
    subscription = Subscription.new(email: subscriptions(:kevin).email)
    assert_not subscription.save
    assert_not subscription.errors[:email].blank?
  end

end
