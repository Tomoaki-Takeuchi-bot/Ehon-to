class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :check_role, only: [:edit, :update, :destroy]

  def index
    @q = Book.ransack(params[:q])
    books = @q.result.includes(:user)
    books = books.where(id: params[:ids]) if params[:ids].present?
    books = books.tagged_with(params[:tag_list], any: true) if params[:tag_list].present?
    @books = books.page(params[:page]).per(5)
  end

  def show
    @book = Book.find(params[:id])
    @comment = Comment.new(book_id: @book.id)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render json: @book, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def favorite
    @book = Book.includes(:favorites).find(params[:book_id])
    @book.has_favorites?(current_user) ? @book.unlike(current_user.id) : @book.like(current_user.id)
    render :favorite
  end

  private

  def book_params
    params.require(:book).permit(
      :name,
      :publisher,
      :author_name,
      :author_image,
      :price,
      :isbn,
      :image,
      :image_cache,
      tag_list: []
    ).merge({ user_id: current_user.id })
  end

  def set_book
    @book = Book.find_with_comments(params[:id])
  end

  def check_role
    redirect_to books_url unless @book.user_id == current_user.id
  end
end
