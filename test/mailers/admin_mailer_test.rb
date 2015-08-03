require 'test_helper'
require 'support/email_fixture'

class AdminMailerTest < ActionMailer::TestCase

  def test_story_approved
    story = stories(:first)
    email = AdminMailer.story_approved(story).deliver_now
    subscribed_emails = Subscription.validated.pluck(:email)

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['noreply@wm-memories.herokuapp.com'], email.from
    assert_equal ['noreply@wm-memories.herokuapp.com'], email.to
    assert_equal "[WM-Memories] #{story.identifier}", email.subject
    assert_equal subscribed_emails, email.bcc

    assert_equal email.parts.count, 2
    email_fixture = EmailFixture.new('story_approved', binding)
    assert_equal email_fixture.text, email.text_part.body.to_s
    assert_equal email_fixture.html, email.html_part.body.to_s
  end

  def test_story_created
    story = stories(:first)
    email = AdminMailer.story_created(story).deliver_now
    admin_emails = Admin.pluck(:email)
    
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['noreply@wm-memories.herokuapp.com'], email.from
    assert_equal admin_emails, email.to
    assert_equal "[WM-Memories] #{story.identifier} Created", email.subject

    assert_equal email.parts.count, 2
    email_fixture = EmailFixture.new('story_created', binding)
    assert_equal email_fixture.text, email.text_part.body.to_s
    assert_equal email_fixture.html, email.html_part.body.to_s
  end

  def test_subscription_verification
    subscription = subscriptions(:avery)
    email = AdminMailer.subscription_verification(subscription).deliver_now
    
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['noreply@wm-memories.herokuapp.com'], email.from
    assert_equal [subscription.email], email.to
    assert_equal '[WM-Memories] Email Verification', email.subject

    assert_equal email.parts.count, 2
    email_fixture = EmailFixture.new('subscription_verification', binding)
    assert_equal email_fixture.text, email.text_part.body.to_s
    assert_equal email_fixture.html, email.html_part.body.to_s
  end
end
