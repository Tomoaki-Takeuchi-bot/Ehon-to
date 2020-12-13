class ApplicationController < ActionController::Base
  # ref:https://github.com/heartcombo/devise#controller-filters-and-helpers
  # コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!

  # deviseで利用出来るパラメーターを設定
  # ref:https://github.com/heartcombo/devise#strong-parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後にBooksの一覧ページへ
  # ref:https://qiita.com/cigalecigales/items/f4274088f20832252374#1-%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E5%BE%8C%E3%81%AE%E3%83%9A%E3%83%BC%E3%82%B8%E3%82%92%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B
  def after_sign_in_path_for(_resource)
    books_path
  end

  # 例外ハンドル
  unless Rails.env.development? # テスト後にdevelopmentに変更
    rescue_from ActiveRecord::RecordNotFound,     with: :_render_404
    rescue_from ActionController::RoutingError,   with: :_render_404
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def _render_404(err = nil)
    logger.info "Rendering 404 with exception: #{err.message}" if err

    if request.format.to_sym == :json
      render json: { error: '404 error' }, status: :not_found
    else
      render 'errors/404.html', status: :not_found
    end
  end

  def _render_500(err = nil)
    logger.error "Rendering 500 with exception: #{err.message}" if err

    if request.format.to_sym == :json
      render json: { error: '500 error' }, status: :internal_server_error
    else
      render 'errors/500.html', status: :internal_server_error
    end
  end

  # protectedで同じクラスやサブクラスの中であれば呼び出し可能にしている
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[name image image_cache]
    )
  end
end
