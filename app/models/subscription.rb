# frozen_string_literal: true
class Subscription < ApplicationRecord

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, presence: true, uniqueness: { message: 'is already subscribed' }, format: EMAIL_REGEX

  scope :email_ordered, -> { order(:email) }
  scope :validated, -> { where(validated: true) }

  after_create { ModeratorMailer.subscription_verification(self).deliver_now }

  # sets validated to true
  def verify!
    update!(validated: true)
  end
end
