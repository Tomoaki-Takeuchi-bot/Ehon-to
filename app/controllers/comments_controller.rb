class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    comment = Comment.new(comment_params)
    comment.save!
    redirect_to books_url, notice: "コメントを登録しました。"
  end

  def edit
  end

  def update
  end

  def desroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:success] = "コメントが削除されました。"
    redirect_to commet.book
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :book_id, :user_id)
  end
end
