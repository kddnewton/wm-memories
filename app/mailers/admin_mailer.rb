class AdminMailer < ApplicationMailer

  # notify subscribers of a story approval
  def story_approved(story)
    @story = story
    emails = Subscription.validated.pluck(:email)
    mail(to: 'noreply@wm-memories.herokuapp.com', subject: "[WM-Memories] #{story.identifier}", bcc: emails)
  end

  # notify admins of a new story
  def story_created(story)
    @story = story
    emails = Admin.pluck(:email)
    mail(to: emails, subject: "[WM-Memories] #{story.identifier} Created") if emails.any?
  end

  # send an email to request verification
  def subscription_verification(subscription)
    @subscription = subscription
    mail(to: subscription.email, subject: "[WM-Memories] Email Verification")
  end

end
