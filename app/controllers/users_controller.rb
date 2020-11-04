class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

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

  def user_delete
    user = User.find(params[:user_id]).destroy
    if user.destroy
      redirect_to root_url, notice: "ユーザー抹消しました。"
    end
  end
end
