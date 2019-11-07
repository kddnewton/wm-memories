# typed: strict
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Stories
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # WM coordinates
    config.x.lat = 37.272385
    config.x.lng = -76.716452
  end
end

# the overall default host
Rails.application.routes.default_url_options[:host] = Rails.env.production? ? 'wm-memories.com' : 'localhost:3000'
