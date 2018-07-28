# frozen_string_literal: true

class Moderator < ApplicationRecord
  validates :email, presence: true, uniqueness: true,
                    format: Subscription::EMAIL_REGEX
end
