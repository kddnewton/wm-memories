require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase

  def test_new
    get :new
    assert_response :success
  end

  def test_create_valid
    post :create, { subscription: { email: 'testemail@test.com' }}
    assert_response :success
  end

  def test_create_invalid
    post :create, { subscription: { email: '' }}
    pending
  end

end
