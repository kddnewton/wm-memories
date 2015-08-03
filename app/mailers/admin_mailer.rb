class AdminMailer < ApplicationMailer

  # notify subscribers of a story approval
  def story_approved(story)
    @story = story
    emails = Subscription.validated.pluck(:email)
    mail(to: 'noreply@wm-memories.herokuapp.com', subject: I18n.t('mailers.admin_mailer.story_approved.subject', story_identifier: story.identifier), bcc: emails)
  end

  # notify admins of a new story
  def story_created(story)
    @story = story
    emails = Admin.pluck(:email)
    mail(to: emails, subject: I18n.t('mailers.admin_mailer.story_created.subject', story_identifier: story.identifier)) if emails.any?
  end

  # send an email to request verification
  def subscription_verification(subscription)
    @subscription = subscription
    mail(to: subscription.email, subject: I18n.t('mailers.admin_mailer.subscription_verification.subject'))
  end
end
