# typed: true
# frozen_string_literal: true

require 'test_helper'

module Stories
  class FeedsControllerTest < ActionController::TestCase
    def test_show
      get :show
      assert_response :success
    end
  end
end
