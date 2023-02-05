class BooksController < ApplicationController
  def new
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "It was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @books = Book.all
    @user = current_user
    @book = Book.new
    @book.user_id = current_user.id
  end

  def show
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @book = Book.find(params[:id])
    @user = current_user
  end

  def edit
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @book = Book.find(params[:id])
  end

  def update
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "It was successfully updated."
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
