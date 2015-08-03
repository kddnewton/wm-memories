class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # authenticate admin actions
  def self.authenticate_admin
    http_basic_authenticate_with name: 'admin', password: Rails.application.secrets.admin_pass
  end

  private

    # translate based on the current controller
    def controller_translate(key, substitutions = {})
      components = ['controllers'] + self.class.name.gsub(/Controller\z/, '').split('::').map(&:downcase) + [key]
      I18n.t(components.join('.'), substitutions)
    end
    alias_method :ct, :controller_translate
end
