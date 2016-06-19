# frozen_string_literal: true
require 'test_helper'

module Admin
  class StoriesControllerTest < ActionController::TestCase

    def setup
      authorize_basic_http
    end

    def test_index
      get :index
      assert_response :success
    end

    def test_approve
      story = stories(:first)
      patch :approve, xhr: true, params: { id: story.id }
      story.reload

      assert_response :success
      assert story.approved?
    end

    def test_show
      get :show, params: { id: stories(:second).id }
      assert_response :success
    end
  end
end
