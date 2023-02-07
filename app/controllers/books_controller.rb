class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
    @book.user_id = current_user.id
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    user_id = @book.user.id
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
    user_id = @book.user.id
    unless user_id == current_user.id
      redirect_to books_path
    else
      render :edit
    end
  end

  def update
    @book = Book.find(params[:id])
    user_id = @book.user.id
    unless user_id == current_user.id
      redirect_to books_path
    end
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

end
