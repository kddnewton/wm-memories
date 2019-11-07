# typed: strict
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  extend T::Sig

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class << self
    extend T::Sig

    # authenticate admin actions
    sig { void }
    def authenticate_admin
      http_basic_authenticate_with(
        name: 'admin',
        password: Rails.application.secrets.admin_pass
      )
    end
  end
end
