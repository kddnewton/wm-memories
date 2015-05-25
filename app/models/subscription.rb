class Subscription < ActiveRecord::Base

  validates :email, presence: true, uniqueness: { message: 'is already subscribed' }, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  scope :email_ordered, ->{ order(:email) }
  scope :validated, ->{ where(validated: true) }

  after_create { AdminMailer.subscription_verification(self).deliver_now }

  # sets validated to true
  def verify!
    self.update!(validated: true)
  end

end
