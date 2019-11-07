# typed: false
# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start('rails')

require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'minitest/mock'
require 'support/validation_assertions'

module ActiveSupport
  class TestCase
    fixtures :all

    include ValidationAssertions
  end
end

module ActionController
  class TestCase
    # authorize using basic http authorization
    def authorize_basic_http
      @request.env['HTTP_AUTHORIZATION'] =
        ActionController::HttpAuthentication::Basic.encode_credentials(
          'admin',
          Rails.application.secrets.admin_pass
        )
    end
  end
end
