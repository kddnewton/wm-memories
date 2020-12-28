# frozen_string_literal: true

require 'test_helper'

module Stories
  class SearchesControllerTest < ActionController::TestCase
    def test_create
      post :create, params: { query: 'test query' }

      assert_response :success
    end
  end
end
