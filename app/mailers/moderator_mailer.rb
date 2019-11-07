# typed: false
# frozen_string_literal: true

class ModeratorMailer < ApplicationMailer
  # notify subscribers of a story approval
  sig { params(story: Story).void }
  def story_approved(story)
    @story = T.let(story, T.nilable(Story))

    emails = Subscription.validated.pluck(:email)
    subject =
      I18n.t(
        'mailers.moderator_mailer.story_approved.subject',
        story_identifier: story.identifier
      )

    mail(to: 'noreply@wm-memories.herokuapp.com', subject: subject, bcc: emails)
  end

  # notify moderators of a new story
  sig { params(story: Story).void }
  def story_created(story)
    @story = T.let(story, T.nilable(Story))

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
  sig { params(subscription: Subscription).void }
  def subscription_verification(subscription)
    @subscription = T.let(subscription, T.nilable(Subscription))

    subject =
      I18n.t('mailers.moderator_mailer.subscription_verification.subject')

    mail(to: subscription.email, subject: subject)
  end
end
