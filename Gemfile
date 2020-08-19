source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'
# gem 'redis', '~> 4.0'
# gem 'image_processing', '~> 1.2'

# =====追加項目=====
# フレームワーク
gem 'bootstrap', '~> 4.5'
# 画像投稿用
gem "carrierwave", "1.2.2"
# リサイズ
gem 'mini_magick'
# ログイン機能
gem 'devise', '~> 4.7', '>= 4.7.2'
# devise日本語化
gem 'devise-i18n'
# ダミーデータ作成
# gem "faker", "~> 2.13"
# aws画像up
# gem "fog-aws", "~> 3.6", ">= 3.6.6"
# font
# gem "font-awesome-sass", "~> 5.13"
# pagenation
gem 'kaminari', '~> 1.2', '>= 1.2.1'
# タグ機能
gem 'acts-as-taggable-on', '~> 6.0'
# railsの日本語化
gem 'rails-i18n'
# 日付バリデーション
gem 'data-validator', '~> 1.1', '>= 1.1.2'
# メールアドレスのバリデーション
gem 'valid_email2', '~> 3.2', '>= 3.2.2'
# URLリンク
# gem "rinku", "~> 2.0", ">= 2.0.6"
# メール送信確認
# gem "mailcatcher"
# XML,HTML解析
# gem "nokogiri"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # =====追加項目=====
  gem 'pry-byebug', '~> 3.9'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # =====追加項目=====
  # assetsの削除に必要となる
  # @sea https://github.com/rails/sprockets/issues/643
  gem 'sprockets', '~> 3.7.2'
  # 複数プロセスを束ねて管理するgem
  # webpacker-dev-server
  gem 'foreman', '~> 0.87.2'
  # スキーマ情報のコメントアウト
  gem 'annotate', '~> 3.1', '>= 3.1.1'
  # N＋1問題対応
  gem 'bullet', '~> 6.1'
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
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers', require: !ENV['SELENIUM_REMOTE_URL']

  # =====追加項目=====
  # CircleCIでRspcのテストレポートを生成する
  # gem "rspec_junit_formatter"
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'rspec-rails', '~>4.0.0'
  # Code coverageツール
  gem 'simplecov', '~> 0.8.1', require: false
end
