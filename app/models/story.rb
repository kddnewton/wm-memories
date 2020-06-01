# typed: strict
# frozen_string_literal: true

class Story < ApplicationRecord
  has_many :photos, dependent: :destroy

  validates :body, :lat, :lng, presence: true
  validates :year, presence: true, inclusion: 1900..Date.today.year

  scope :approved, -> { where(approved: true) }
  scope :feed_ordered, -> { order('created_at DESC') }
  scope :search, ->(query) { where('body LIKE ?', "%#{query}%") }

  after_create_commit :enqueue_mail

  # approve this story by moderator
  sig { void }
  def approve!
    update!(approved: true)
    ModeratorMailer.story_approved(self).deliver_now

    link = Rails.application.routes.url_helpers.story_url(self)
    TwitterInterface.update("#{body.truncate(100)} #{link}")
  end

  # long-form id
  sig { returns(String) }
  def identifier
    I18n.t('models.story.identifier', year: year) % id
  end

  # build the photo objects
  sig {
    params(
      photo_proxies: T.nilable(
        T.any(
          T::Array[ActionDispatch::Http::UploadedFile],
          T::Array[Rack::Test::UploadedFile]
        )
      )
    ).void
  }
  def photo_proxies=(photo_proxies)
    (photo_proxies || []).each do |photo_proxy|
      photos.build(attachment: photo_proxy)
    end
  end

  private

  sig { void }
  def enqueue_mail
    ModeratorMailer.story_created(self).deliver_now
  end
end
