class Admin < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true, format: Subscription::EMAIL_REGEX

end
