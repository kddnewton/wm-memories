ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start('rails')

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/mock'

require 'support/validation_assertions'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include ValidationAssertions

  # Add more helper methods to be used by all tests here...
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
