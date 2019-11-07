# typed: strict
# frozen_string_literal: true

class Subscription < ApplicationRecord
  EMAIL_REGEX =
    T.let(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.freeze, Regexp)

  validates :email, presence: true,
                    uniqueness: { message: 'is already subscribed' },
                    format: EMAIL_REGEX

  scope :email_ordered, -> { order(:email) }
  scope :validated, -> { where(validated: true) }

  after_create_commit do |subscription|
    ModeratorMailer.subscription_verification(subscription).deliver_now
  end

  # sets validated to true
  sig { returns(TrueClass) }
  def verify!
    update!(validated: true)
  end
end
