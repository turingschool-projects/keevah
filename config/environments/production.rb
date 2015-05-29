Rails.application.configure do
  config.paperclip_defaults = {
    storage: :s3,
    s3_credentials: {
      bucket: ENV['S3_BUCKET_NAME'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
  }

  config.cache_store = :dalli_store,
    (ENV["MEMCACHIER_SERVERS"] || "").split(","),
    {
      username: ENV["MEMCACHIER_USERNAME"],
      password: ENV["MEMCACHIER_PASSWORD"],
      failover: true,
      socket_timeout: 1.5,
      socket_failure_delay: 0.2
    }

    ActionMailer::Base.smtp_settings = {
      port:           '587',
      address:        'smtp.mandrillapp.com',
      user_name:      ENV['MANDRILL_USERNAME'],
      password:       ENV['MANDRILL_APIKEY'],
      domain:         'heroku.com',
      authentication: :plain
    }

    ActionMailer::Base.delivery_method = :smtp

    config.cache_classes = true

    config.eager_load = true

    config.consider_all_requests_local       = false

    config.action_controller.perform_caching = true

    config.serve_static_files = true

    config.assets.js_compressor = :uglifier

    config.assets.compile = true

    config.assets.digest = true

    config.log_level = :info

    config.force_ssl = true

    # Prepend all log lines with the following tags.
    # config.log_tags = [ :subdomain, :uuid ]

    # Use a different logger for distributed setups.
    # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

    # Enable serving of images, stylesheets, and JavaScripts from an asset server.
    # config.action_controller.asset_host = 'http://assets.example.com'

    # Ignore bad email addresses and do not raise email delivery errors.
    # Set this to true and configure the email server for immediate delivery to raise delivery errors.
    # config.action_mailer.raise_delivery_errors = false

    # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
    # the I18n.default_locale when a translation cannot be found).
    config.i18n.fallbacks = true

    # Send deprecation notices to registered listeners.
    config.active_support.deprecation = :notify

    # Use default logging formatter so that PID and timestamp are not suppressed.
    config.log_formatter = ::Logger::Formatter.new

    # Do not dump schema after migrations.
    config.active_record.dump_schema_after_migration = false
end
