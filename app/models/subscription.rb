class Subscription < ActiveRecord::Base

  validates :email, presence: true, uniqueness: { message: 'That email is already subscribed.' }

  scope :email_ordered, ->{ order(:email) }
  scope :validated, ->{ where(validated: true) }

end
