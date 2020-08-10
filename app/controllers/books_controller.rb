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
    @book = Book.new(book_params.merge(user_id: current_user.id))
    category_list = params[:category_list].to_s.split(",") #to_sにしないとエラー
    if @book.save
      @book.save_categories(category_list)
      redirect_to books_path, notice: "本「#{@book.name}」を登録しました。"
    else
      render 'books/new'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @category_list = @book.categories.pluck(:name).join(",")
  end

  def update
    @book = Book.find(params[:id])
    category_list = params[:category_list].to_s.split(",") #to_sにしないとエラー
    if book.update(book_params)
      book.save_categories(category_list)
      redirect_to books_url, notice: "「#{@book.name}」の内容を更新しました。"
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_url, notice: "本「#{book.name}」を削除しました。"
  end

  def favorite
    @book = Book.includes(:favorites).find(params[:book_id])
    @book.has_favorites?(current_user) ? @book.unlike(current_user.id) : @book.like(current_user.id)
    render :favorite
  end

  private

  def book_params
    params.require(:book).permit(:name, :publisher, :author_name, :author_image, :price, :isbn)
  end
end
