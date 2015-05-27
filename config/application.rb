require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Keevahh
  class Application < Rails::Application
    config.serve_static_files = true
    config.assets.version = '1.1'
    config.expections_app = routes

    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address:              "smtp.mandrillapp.com",
      port:                 "587",
      domain:               "gmail.com",
      user_name:            ENV['MANDRIL_USERNAME'],
      password:             ENV['MANDRIL_API_KEY'],
      authentication:       "plain",
      enable_starttls_auto: true
    }

  end
end
