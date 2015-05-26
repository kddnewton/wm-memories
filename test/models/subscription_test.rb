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

  def test_email_format_validation
    subscription = Subscription.new(email: 'testemailtest.com')
    assert_not subscription.save
    assert_not subscription.errors[:email].blank?
  end

  def test_after_create_mailer
    subscription = Subscription.new(email: 'testemail@test.com')

    mailer_mock = Minitest::Mock.new
    mailer_mock.expect :deliver_now, nil

    AdminMailer.stub :subscription_verification, mailer_mock do
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
