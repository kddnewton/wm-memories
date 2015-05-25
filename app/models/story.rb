class Story < ActiveRecord::Base

  validates :body, presence: true
  validates :year, presence: true, inclusion: 1900..Date.today.year

  scope :feed_ordered, ->{ order('created_at DESC') }
  scope :search, ->(query){ where('body LIKE ?', "%#{query}%") }

  after_create { AdminMailer.story_created(self).deliver_now }

  # long-form id
  def identifier
    "Story %03d" % self.id
  end

end
