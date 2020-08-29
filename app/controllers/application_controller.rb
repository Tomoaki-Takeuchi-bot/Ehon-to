class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後にBooksの一覧ページへ
  def after_sign_in_path_for(resource)
    books_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[name image image_cache]
    )
  end
end
