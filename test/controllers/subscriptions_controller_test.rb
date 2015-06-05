require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase

  def test_new
    get :new
    assert_response :success
  end

  def test_create_valid
    post :create, params: { subscription: { email: 'testemail@test.com' }}
    assert_response :success
  end

  def test_create_invalid
    post :create, params: { subscription: { email: '' }}
  end

  def test_verify
    subscription = subscriptions(:avery)
    get :verify, params: { id: subscription.id }
    subscription.reload

    assert subscription.validated?
  end

end
