Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  # --追加事項 gmail設定--
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  if Rails.application.credentials.gmail.present?
    mail_address = Rails.application.credentials.gmail[:address]
    password = Rails.application.credentials.gmail[:password]
  else
    mail_address = 'admin@example.com'
    password = 'password'
  end

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    enable_starttls_auto: true,
    address: 'smtp.gmail.com',
    port: 587,
    user_name: mail_address,
    password: password,
    authentication: 'plain'
  }

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # --追加事項（ウェブコンソール）--
  # 172.16.0.0-172.31.255.255まで
  config.web_console.whitelisted_ips = %w[172.16.0.0/12]

  # --追加事項（deviseインストール) --
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # --追加項目（Bettar Error）設定ーー
  # https://github.com/BetterErrors/better_errors/issues/270
  BetterErrors::Middleware.allow_ip! '0.0.0.0/0' if Rails.env.development?
end
