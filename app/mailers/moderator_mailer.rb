# typed: true
# frozen_string_literal: true

class ModeratorMailer < ApplicationMailer
  # notify subscribers of a story approval
  def story_approved(story)
    @story = story

    emails = Subscription.validated.pluck(:email)
    subject =
      I18n.t(
        'mailers.moderator_mailer.story_approved.subject',
        story_identifier: story.identifier
      )

    mail(to: 'noreply@wm-memories.herokuapp.com', subject: subject, bcc: emails)
  end

  # notify moderators of a new story
  def story_created(story)
    @story = story

    emails = Moderator.pluck(:email)
    return if emails.empty?

    subject =
      I18n.t(
        'mailers.moderator_mailer.story_created.subject',
        story_identifier: story.identifier
      )

    mail(to: emails, subject: subject)
  end

  # send an email to request verification
  def subscription_verification(subscription)
    @subscription = subscription

    subject =
      I18n.t('mailers.moderator_mailer.subscription_verification.subject')

    mail(to: subscription.email, subject: subject)
  end
end
