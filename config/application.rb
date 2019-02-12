require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Tracker
  class Application < Rails::Application

    config.load_defaults 5.2
    
    # Set default time zone.
    config.time_zone = "Eastern Time (US & Canada)"

    # Load custom config for HTTP authentication.
    config.tracker_auth = config_for(:tracker_auth)

  end
end