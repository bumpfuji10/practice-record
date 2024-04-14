require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module PracticeRecord
  class Application < Rails::Application
    config.load_defaults 7.0
    config.middleware.use ActionDispatch::Cookies
    config.api_only = true

  end
end
