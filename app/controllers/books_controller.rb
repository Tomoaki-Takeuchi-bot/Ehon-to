class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @comment = Comment.new(book_id: @book.id)
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params.merge(user_id: current_user.id))
    book.save!
    redirect_to books_path, notice: "本「#{book.name}」を登録しました。"
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update!(book_params)
    redirect_to books_url, notice: "「#{book.name}」の内容を更新しました。"
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_url, notice: "本「#{book.name}」を削除しました。"
  end

  private

  def book_params
    params.require(:book).permit(:name, :publisher, :author_name, :author_image, :price, :isbn)
  end
end
