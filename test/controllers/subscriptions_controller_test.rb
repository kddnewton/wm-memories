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
    assert_template :new
  end

  def test_verify
    subscription = subscriptions(:avery)
    get :verify, { id: subscription.id }
    subscription.reload

    assert subscription.validated?
  end

end
