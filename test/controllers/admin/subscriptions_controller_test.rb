require 'test_helper'

class Admin::SubscriptionsControllerTest < ActionController::TestCase

  def test_index
    authorize_basic_http
    get :index
    assert_response :success
  end

end