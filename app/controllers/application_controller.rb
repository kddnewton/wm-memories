# typed: true
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # authenticate admin actions
  def self.authenticate_admin
    http_basic_authenticate_with(
      name: 'admin',
      password: Rails.application.secrets.admin_pass
    )
  end
end
