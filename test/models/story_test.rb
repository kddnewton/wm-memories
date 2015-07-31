require 'test_helper'

class StoryTest < ActiveSupport::TestCase

  def test_presence_validations
    assert_validates_presence_of Story, :body, :lat, :lng, :year
  end

  def test_year_inclusion_validation
    assert_validates_inclusion_of Story, :year, 1800
  end

  def test_after_create
    story = Story.new(body: 'test body', year: 1900, lat: Rails.configuration.x.lat, lng: Rails.configuration.x.lng)
    mailer_mock = Minitest::Mock.new
    mailer_mock.expect :deliver_now, nil

    AdminMailer.stub :story_created, mailer_mock do
      assert story.save
    end
    mailer_mock.verify
  end

  def test_approve
    story = stories(:first)
    mailer_mock = Minitest::Mock.new
    mailer_mock.expect :deliver_now, nil

    AdminMailer.stub :story_approved, mailer_mock do
      assert story.approve!
    end

    mailer_mock.verify
    assert story.approved?
    assert_equal Rails.configuration.x.twitter.class.last_tweet, story.body + ' ' + Rails.application.routes.url_helpers.story_url(story)
  end

  def test_identifier
    story = stories(:first)
    assert_equal ("Story %03d (Class of 2013)" % story.id), story.identifier
  end

end