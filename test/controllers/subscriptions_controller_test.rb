# typed: false
# frozen_string_literal: true

require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_response :success
  end

  def test_create_valid
    assert_difference 'Subscription.count', 1 do
      post :create, params: { subscription: { email: 'testemail@test.com' } }
    end
    assert_response :success
  end

  def test_create_invalid
    assert_no_difference 'Subscription.count' do
      post :create, params: { subscription: { email: '' } }
    end
    assert_response :success
  end

  def test_verify
    subscription = subscriptions(:avery)
    get :verify, params: { id: subscription.id }
    subscription.reload
    assert subscription.validated?
  end
end
