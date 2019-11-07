# typed: true
# frozen_string_literal: true

require 'test_helper'

module Admin
  class ApprovalsControllerTest < ActionController::TestCase
    def setup
      authorize_basic_http
    end

    def test_approve
      story = stories(:first)
      post :create, xhr: true, params: { story_id: story.id }
      story.reload

      assert_response :success
      assert story.approved?
    end
  end
end
