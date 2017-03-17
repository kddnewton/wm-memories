# frozen_string_literal: true
require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def test_email_presence_validation
    assert_validates_presence_of Subscription, :email
  end

  def test_email_uniqueness_validation
    assert_validates_uniqueness_of Subscription, :email, message: 'is already subscribed'
  end

  def test_email_format_validation
    assert_validates_format_of Subscription, :email, 'testemailtest.com'
  end

  def test_after_create_mailer
    subscription = Subscription.new(email: 'testemail@test.com')

    mailer_mock = Minitest::Mock.new
    mailer_mock.expect :deliver_now, nil

    ModeratorMailer.stub :subscription_verification, mailer_mock do
      assert subscription.save
    end
    mailer_mock.verify
  end

  def test_verify
    subscription = subscriptions(:avery)
    subscription.verify!
    assert subscription.validated?
  end
end
