# frozen_string_literal: true
class ModeratorMailer < ApplicationMailer
  # notify subscribers of a story approval
  def story_approved(story)
    @story = story
    emails = Subscription.validated.pluck(:email)
    mail(
      to: 'noreply@wm-memories.herokuapp.com',
      subject: I18n.t('mailers.moderator_mailer.story_approved.subject', story_identifier: story.identifier),
      bcc: emails
    )
  end

  # notify moderators of a new story
  def story_created(story)
    @story = story
    emails = Moderator.pluck(:email)
    return if emails.empty?

    mail(
      to: emails,
      subject: I18n.t('mailers.moderator_mailer.story_created.subject', story_identifier: story.identifier)
    )
  end

  # send an email to request verification
  def subscription_verification(subscription)
    @subscription = subscription
    mail(to: subscription.email, subject: I18n.t('mailers.moderator_mailer.subscription_verification.subject'))
  end
end
