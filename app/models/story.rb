class Story < ApplicationRecord

  has_many :photos, dependent: :destroy

  validates :body, :lat, :lng, presence: true
  validates :year, presence: true, inclusion: 1900..Date.today.year

  scope :approved, ->{ where(approved: true) }
  scope :feed_ordered, ->{ order('created_at DESC') }
  scope :search, ->(query){ where('body LIKE ?', "%#{query}%") }

  after_create { AdminMailer.story_created(self).deliver_now }

  attr_reader :photo_proxies

  # approve this story by admin
  def approve!
    self.update!(approved: true)
    AdminMailer.story_approved(self).deliver_now
    Rails.configuration.x.twitter.update(self.body.truncate(100) + ' ' + Rails.application.routes.url_helpers.story_url(self))
  end

  # long-form id
  def identifier
    I18n.t('models.story.identifier', year: self.year) % self.id
  end

  # build the photo objects
  def photo_proxies=(photo_proxies)
    (photo_proxies || []).each do |photo_proxy|
      self.photos.build(attachment: photo_proxy)
    end
  end
end
