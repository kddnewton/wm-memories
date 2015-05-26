require 'test_helper'

class EmailFixture

  attr_reader :text, :html

  # store the text and html
  def initialize(name, current_binding)
    @name = name
    @text = read('text', current_binding)
    @html = read('html', current_binding)
  end

  private

    # read the part from a fixture
    def read(part, current_binding)
      plain = IO.readlines(Rails.root.join('test', 'fixtures', 'admin_mailer', "#{@name}.#{part}.erb")).join
      ERB.new(plain).result(current_binding)
    end

end

class AdminMailerTest < ActionMailer::TestCase

  def test_story_created
    story = stories(:first)
    email = AdminMailer.story_created(story).deliver_now
    subscribed_emails = Subscription.validated.pluck(:email)
    
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['noreply@wm-memories.herokuapp.com'], email.from
    assert_equal ['kevin.deisz@gmail.com'], email.to
    assert_equal "[WM-Memories] #{story.identifier} Created", email.subject
    assert_equal subscribed_emails, email.bcc

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
    assert_equal "[WM-Memories] Email Verification", email.subject

    assert_equal email.parts.count, 2
    email_fixture = EmailFixture.new('subscription_verification', binding)
    assert_equal email_fixture.text, email.text_part.body.to_s
    assert_equal email_fixture.html, email.html_part.body.to_s
  end

end
