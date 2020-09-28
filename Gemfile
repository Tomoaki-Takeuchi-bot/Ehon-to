source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'bcrypt'
gem 'bootsnap', require: false
gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'sass-rails'
gem 'webpacker'

# =====追加項目=====
# フレームワーク
gem 'bootstrap'
# 画像投稿用
gem 'carrierwave'
# リサイズ
gem 'mini_magick'
# 検索機能
gem 'ransack'
# ログイン機能
gem 'devise'
# devise日本語化
gem 'devise-i18n'
# ダミーデータ作成
gem 'faker'
# aws画像up
gem 'fog-aws'
# pagenation
gem 'kaminari'
# タグ機能
gem 'acts-as-taggable-on'
# railsの日本語化
gem 'rails-i18n'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # =====追加項目=====
  gem 'pry-byebug'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'

  # =====追加項目=====
  # assetsの削除に必要となる,バージョン指定必要
  # @ref: https://github.com/rails/sprockets/issues/643
  gem 'sprockets', '~> 3.7.2'
  # 複数プロセスを束ねて管理するgem
  # webpacker-dev-server
  gem 'foreman'
  # スキーマ情報のコメントアウト
  gem 'annotate'
  # N＋1問題対応
  gem 'bullet'
  # コード解析
  gem 'rubocop', require: false
  # コード解析 rails
  gem 'rubocop-rails', require: false
  # rspec高速化
  gem 'spring-commands-rspec'
  # Railsエラー置き換え
  gem 'better_errors'
  # Railsエラー高度機能使用
  gem 'binding_of_caller'
  # gem脆弱性診断
  gem 'bundler-audit'
  # セキュリティ診断
  gem 'brakeman'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers', require: !ENV['SELENIUM_REMOTE_URL']

  # =====追加項目=====
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  # Code coverageツール
  gem 'simplecov', require: false
end
