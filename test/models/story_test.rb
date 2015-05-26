require 'test_helper'

class StoryTest < ActiveSupport::TestCase

  def test_body_presence_validation
    story = Story.new(year: 1900)
    assert_not story.save
    assert_not story.errors[:body].blank?
  end

  def test_year_presence_validation
    story = Story.new(body: 'test body')
    assert_not story.save
    assert_not story.errors[:year].blank?
  end

  def test_year_inclusion_validation
    story = Story.new(body: 'test body', year: 1800)
    assert_not story.save
    assert_not story.errors[:year].blank?
  end

  def test_approve
    story = stories(:first)
    mailer_mock = Minitest::Mock.new
    mailer_mock.expect :deliver_now, nil

    AdminMailer.stub :story_created, mailer_mock do
      assert story.approve!
    end

    mailer_mock.verify
    assert story.approved?
    assert_equal Rails.configuration.x.twitter.class.last_tweet, story.body + ' ' + Rails.application.routes.url_helpers.story_url(story)
  end

  def test_identifier
    story = stories(:first)
    assert_equal ("Story %03d" % story.id), story.identifier
  end

end
