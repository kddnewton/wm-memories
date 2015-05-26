class AdminMailer < ApplicationMailer

  # notify of a new story
  def story_created(story)
    @story = story
    emails = Subscription.validated.pluck(:email)
    mail(to: 'kevin.deisz@gmail.com', subject: "[WM-Memories] #{story.identifier} Created", bcc: emails)
  end

  # send an email to request verification
  def subscription_verification(subscription)
    @subscription = subscription
    mail(to: subscription.email, subject: "[WM-Memories] Email Verification")
  end

end
