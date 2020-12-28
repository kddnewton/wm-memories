# frozen_string_literal: true

require 'test_helper'

class VerificationsControllerTest < ActionController::TestCase
  def test_show
    subscription = subscriptions(:avery)
    get :show, params: { subscription_id: subscription.id }

    subscription.reload
    assert subscription.validated?
  end
end
