# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#

# --追加事項 support配下のテスト読み込み --
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each do |f|
  require f
end

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # -- 追加事項  --
  # create,build を使えるようにする
  config.include FactoryBot::Syntax::Methods
  # テストで使う共通関数をまとめたModule
  config.include SpecSupport
  # Deviseでのログイン
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # --追加項目 --
  # Capybaraのセッティング
  config.before(:each, type: :system) do
    Capybara.default_driver = :selenium_chrome
    Capybara.javascript_driver = :selenium_chrome
    Capybara.server_host =
      Socket.ip_address_list.detect(&:ipv4_private?).ip_address
    Capybara.server_port = 3001
    Capybara.default_max_wait_time = 5
    Capybara.ignore_hidden_elements = true

    Capybara.register_driver :selenium_chrome do |app|
      url = 'http://chrome:4444/wd/hub'
      opts = { desired_capabilities: :chrome, browser: :remote, url: url }
      driver = Capybara::Selenium::Driver.new(app, opts)
    end

    driven_by Capybara.javascript_driver
    host! "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end

  # --追加項目--
  # coverageのエクスポート
  # coverageテスト結果出力が必要な際は env COVERAGE=true を渡してください。
  # 下記はコマンド例
  # example: docker-compose run --rm -e COVERAGE=true web bundle exec rspec
  if ENV['COVERAGE']
    require 'simplecov'

    # カバレッジが90以下は失敗
    SimpleCov.minimum_coverage 90

    # カバレッジの出力先変更
    SimpleCov.coverage_dir('tmp/cov')

    SimpleCov.start do
      # spec dir を除く
      add_filter '/spec/'

      # group folders
      # you can't get coverage for view. @see https://github.com/colszowka/simplecov/issues/38
      add_group 'Models', 'app/models'
      add_group 'Controllers', 'app/controllers'
    end
  end
end
