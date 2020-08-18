class CommentsController < ApplicationController
  before_action :set_book

  def create
    @book.comments.new(comment_params).save
    render :remote_js
  end

  def destroy
    @book.comments.destroy(params[:id]) if current_user.id == @book.comments.find(params[:id]).user_id
    render :remote_js
  end

  private

    def set_book
      @book = Book.find_with_comments(params[:book_id])
    end

    def comment_params
      params.require(:comment).permit(:comment).merge(user_id: current_user.id)
    end
end