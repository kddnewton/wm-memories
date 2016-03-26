ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start('rails')

require 'knapsack'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/mock'

require 'support/validation_assertions'

class ActiveSupport::TestCase
  fixtures :all

  include ValidationAssertions

  def pending
    assert false, "Pending #{caller[0]}"
  end
end

class ActionController::TestCase
  # authorize using basic http authorization
  def authorize_basic_http
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('admin', Rails.application.secrets.admin_pass)
  end
end

Knapsack::Adapters::MinitestAdapter.bind.set_test_helper_path(__FILE__)
