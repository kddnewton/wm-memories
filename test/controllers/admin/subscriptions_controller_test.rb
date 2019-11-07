# typed: ignore
# frozen_string_literal: true

require 'test_helper'

module Admin
  class SubscriptionsControllerTest < ActionController::TestCase
    def test_index
      authorize_basic_http
      get :index
      assert_response :success
    end
  end
end
