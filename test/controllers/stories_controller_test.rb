require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_response :success
  end

  def test_show
    get :show, params: { id: stories(:second).id }
    assert_response :success
  end

  def test_create_valid
    assert_difference 'Story.count', 1 do
      post :create, xhr: true, params: { story: create_params }
    end
    assert_response :success
  end

  def test_create_invalid
    assert_no_difference 'Story.count' do
      post :create, xhr: true, params: { story: { year: '', body: '' } }
    end
    assert_response :success
  end

  def test_feed
    get :feed
    assert_response :success
  end

  def test_search
    post :search, params: { query: 'test query' }
    assert_response :success
  end

  private

  def create_params
    {
      year: 2013,
      body: 'test body',
      lat: Rails.configuration.x.lat,
      lng: Rails.configuration.x.lng
    }
  end
end
