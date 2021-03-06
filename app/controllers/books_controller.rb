class BooksController < ApplicationController
  # ref:before action :https://github.com/heartcombo/devise#controller-filters-and-helpers
  before_action :set_book, only: %i[show edit update destroy]
  before_action :check_role, only: %i[edit update destroy]

  # 検索ransack使用 ransackメソッド
  # https://github.com/activerecord-hackery/ransack#simple-mode
  def index
    @q = Book.ransack(params[:q])

    # ref: https://github.com/activerecord-hackery/ransack#in-your-controller
    books = @q.result.includes(:user)
    books = books.where(id: params[:ids]) if params[:ids].present?
    if params[:tag_list].present?
      books = books.tagged_with(params[:tag_list], any: true) # ref: any:https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/any=3f.html
    end
    @books = books.page(params[:page]).per(6)
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
        format.html do
          redirect_to books_url, notice: '本の登録が完了しました。'
        end
        format.json { render json: @book, status: :created }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html do
          redirect_to books_url, notice: '本の更新が完了しました。'
        end
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
      format.html { redirect_to books_url, notice: '本の削除が完了しました。' }
      format.json { head :no_content }
    end
  end

  def favorite
    @book = Book.includes(:favorites).find(params[:book_id])
    if @book.has_favorites?(current_user)
      @book.unlike(current_user.id)
    else
      @book.like(current_user.id)
    end
    render :favorite
  end

  # protectedで同じクラスやサブクラスの中であれば呼び出し可能にしている
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
    @book = Book.find(params[:id])
  end

  # 現状ユーザーが本の登録者または管理者でない限り リダイレクトする
  def check_role
    redirect_to books_url unless @book.user_id == current_user.id || current_user.admin
  end
end
