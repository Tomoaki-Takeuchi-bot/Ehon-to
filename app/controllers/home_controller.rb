class HomeController < ApplicationController
  # ログイン済ユーザーのみにアクセスを許可する
  skip_before_action :authenticate_user!, only: :index

  def index; end
end
