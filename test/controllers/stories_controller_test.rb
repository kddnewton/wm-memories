require 'test_helper'

class StoriesControllerTest < ActionController::TestCase

  def test_index
    get :index
    assert_response :success
  end

  def test_show
    get :show, { id: stories(:first).id }
    assert_response :success
  end

  def test_create_valid
    assert_difference('Story.count', 1) do
      post :create, { story: { year: 2013, body: 'test body', lat: Rails.configuration.x.lat, lng: Rails.configuration.x.lng }}
    end
    assert_redirected_to stories_path
  end

  def test_create_invalid
    assert_no_difference('Story.count') do
      post :create, { story: { year: '', body: '' }}
    end
    assert_template :create
  end

  def test_feed
    get :feed
    assert_response :success
  end

  def test_search
    post :search, { query: 'test query' }
    assert_response :success
  end

end
