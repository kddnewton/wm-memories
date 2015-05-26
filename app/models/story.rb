class Story < ActiveRecord::Base

  validates :body, presence: true
  validates :year, presence: true, inclusion: 1900..Date.today.year

  scope :feed_ordered, ->{ order('created_at DESC') }
  scope :search, ->(query){ where('body LIKE ?', "%#{query}%") }

  after_create do
    AdminMailer.story_created(self).deliver_now
    Rails.configuration.x.twitter.update(self.body.truncate(100) + ' ' + Rails.application.routes.url_helpers.story_url(self))
  end

  # long-form id
  def identifier
    "Story %03d" % self.id
  end

end
