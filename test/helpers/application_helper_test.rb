require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  include ApplicationHelper

  attr_reader :request

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
