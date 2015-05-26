require 'test_helper'

class Admin::StoriesControllerTest < ActionController::TestCase

  def setup
    authorize_basic_http
  end

  def test_index
    get :index
    assert_response :success
  end

  def test_approve
    story = stories(:first)
    xhr :patch, :approve, { id: story.id }
    story.reload

    assert_response :success
    assert story.approved?
  end

end
