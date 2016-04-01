require 'test_helper'

class StoryRelayJobTest < ActiveJob::TestCase

  def test_story_approval
    story = stories(:first)
    mock = Minitest::Mock.new
    mock.expect(:call, nil, [story])

    StoryRelayJob.stub(:perform_now, mock) do
      story.approve!
    end

    mock.verify
  end

  def test_job
    story = stories(:first)

    mailer_mock = Minitest::Mock.new
    mailer_mock.expect(:deliver_now, nil)

    cable_mock = Minitest::Mock.new
    cable_mock.expect(:broadcast, nil, ['stories', story: story.attributes.slice('lat', 'lng', 'body', 'id')])

    AdminMailer.stub(:story_approved, mailer_mock) do
      ActionCable.stub(:server, cable_mock) do
        StoryRelayJob.perform_now(story)
      end
    end

    mailer_mock.verify
    # cable_mock.verify
    assert_equal(TwitterInterface.instance.last_tweet, story.body + ' ' + Rails.application.routes.url_helpers.story_url(story))
  end
end
