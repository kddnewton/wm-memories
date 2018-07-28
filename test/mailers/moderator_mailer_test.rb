# frozen_string_literal: true

require 'test_helper'
require 'support/email_fixture'

class ModeratorMailerTest < ActionMailer::TestCase
  def test_story_approved_properties
    story = stories(:first)
    email = ModeratorMailer.story_approved(story).deliver_now
    subscribed_emails = Subscription.validated.pluck(:email)

    assert_email_properties(
      email,
      from: ['noreply@wm-memories.herokuapp.com'],
      to: ['noreply@wm-memories.herokuapp.com'],
      subject: "[WM-Memories] #{story.identifier}",
      bcc: subscribed_emails
    )
  end

  def test_story_approved_body
    email = ModeratorMailer.story_approved(stories(:first)).deliver_now
    assert_email_body email, 'story_approved'
  end

  def test_story_created_properties
    story = stories(:first)
    email = ModeratorMailer.story_created(story).deliver_now
    moderator_emails = Moderator.pluck(:email)

    assert_not ActionMailer::Base.deliveries.empty?

    assert_email_properties(
      email,
      from: ['noreply@wm-memories.herokuapp.com'],
      to: moderator_emails,
      subject: "[WM-Memories] #{story.identifier} Created"
    )
  end

  def test_story_created_body
    email = ModeratorMailer.story_created(stories(:first)).deliver_now
    assert_email_body email, 'story_created'
  end

  def test_subscription_verification_properties
    subscription = subscriptions(:avery)
    email = ModeratorMailer.subscription_verification(subscription).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_email_properties(
      email,
      from: ['noreply@wm-memories.herokuapp.com'],
      to: [subscription.email],
      subject: '[WM-Memories] Email Verification'
    )
  end

  def test_subscription_verification_body
    subscription = subscriptions(:avery)
    email = ModeratorMailer.subscription_verification(subscription).deliver_now

    assert_email_body email, 'subscription_verification'
  end

  private

  def assert_email_body(email, method)
    assert_equal 2, email.parts.count
    assert_email_body_parts email, EmailFixture.new(method, binding)
  end

  def assert_email_body_parts(email, email_fixture)
    assert_equal email.text_part.body.to_s, email_fixture.text
    assert_equal email.html_part.body.to_s, email_fixture.html
  end

  def assert_email_properties(email, properties)
    properties.each do |key, value|
      assert_equal value, email.send(key)
    end
  end
end
