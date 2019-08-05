require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SandwhichSoupSalad
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

Unsplash.configure do |config|
  config.application_access_key = "fc0b78fd785faf77bea9adc445954873724c3f4175b459ee9d86e5b85802b0f7"
  config.application_secret = "0f2437a23c4627e99cf8131a8ae820eee9c4800b6098f96c19086b5f44b7be91"
  config.application_redirect_uri = "http://food.thelandofrohan.com/oauth/callback"
  config.utm_source = "sandwhich_soup_salad"
end