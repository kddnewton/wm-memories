require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  include ApplicationHelper

  attr_reader :request

  def test_init_map_from
    story = stories(:first)
    stories = Story.where(id: story.id)
    result = init_map_from(stories).match(/\[.*\]/)[0]
    assert_equal result, [{ lat: story.lat, lng: story.lng, body: "#{story.identifier}: #{story.body}", storyId: story.id }].to_json
  end

  def test_nav_link
    result = nav_link('test', root_path, :test)
    assert_equal result, "<a class=\"col-sm-2 col-xs-4 \" href=\"/\"><span class=\"glyphicon glyphicon-test\"></span>&nbsp<span class=\"hidden-xs\">test</span></a>"
  end

  def test_story_body_feed
    story = stories(:first)
    result = story_body(story, context: :feed)
    assert_equal result, "<p>This is my first test story.</p>"
  end

  def test_story_body_search
    @query = 'This'
    story = stories(:first)
    result = story_body(story, context: :search)
    assert_equal result, "<p><mark>This</mark> is my first test story.</p>"
  end

end
