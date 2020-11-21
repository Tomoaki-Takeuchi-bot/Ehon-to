class CommentsController < ApplicationController
  before_action :set_book

  # コメント作成・保存
  def create
    @book.comments.new(comment_params).save
    render :remote_js
  end

  # 現ユーザーが登録者または管理者の場合削除可能
  def destroy
    if current_user.id == @book.comments.find(params[:id]).user_id || current_user.admin
      @book.comments.destroy(params[:id])
    end
    render :remote_js
  end

  private

  # 本のセット
  def set_book
    @book = Book.find(params[:book_id])
  end

  # user_id: 現行ユーザーのコメントと紐付け
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id)
  end
end
