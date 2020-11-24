class UsersController < ApplicationController

  # ransackでパラメーター取得
  # https://github.com/activerecord-hackery/ransack#in-your-controller
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(10)
  end

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
  end

  # フォロー機能
  def follow
    other_user_id = params[:user_id]
    @user = User.find(other_user_id)
    if current_user.following?(@user)
      current_user.unfollow(other_user_id)
    else
      current_user.follow(other_user_id)
    end
    render :follow
  end

  #
  def user_delete
    # 管理者限定機能へのアクセス拒否（現行ユーザーがadminでない場合）
    raise '管理者限定機能です' unless current_user.admin

    user = User.find(params[:user_id])
    # ユーザー抹消後にroot_urlへredirectで１回ずつ確認
    redirect_to root_url, notice: 'ユーザー抹消しました。' if user.destroy
  end
end
