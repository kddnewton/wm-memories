# typed: true
# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  def test_about
    get :about
    assert_response :success
  end
end
