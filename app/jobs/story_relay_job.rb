class StoryRelayJob < ApplicationJob

  queue_as :default

  def perform(story)
    ActionCable.server.broadcast('stories', story: serialize_story(story))
    AdminMailer.story_approved(story).deliver_now
    Rails.configuration.x.twitter.update(story.body.truncate(100) + ' ' + Rails.application.routes.url_helpers.story_url(story))
  end

  private

    def serialize_story(story)
      story.attributes.slice('lat', 'lng', 'body', 'id')
    end
end
