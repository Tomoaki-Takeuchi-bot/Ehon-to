require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 6.0

    # ----
    # 追加事項（タイムゾーン）
    config.time_zone = 'Tokyo'
    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # 追加事項（ロケールファイル読みこみ先）
    config.i18n.default_locale = :ja

    # 追加事項（ジェネレーター設定）
    config.generators do |g|
      g.test_framework :rspec
      g.controller_specs false
      g.view_specs false
      # ----

      config.generators.system_tests = nil
    end
  end
end
