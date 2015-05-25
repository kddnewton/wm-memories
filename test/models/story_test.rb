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

  def test_after_create
    pending
  end

  def test_identifier
    story = stories(:first)
    assert_equal ("Story %03d" % story.id), story.identifier
  end

end
