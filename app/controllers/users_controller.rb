class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
    user_id = @book.user.id
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
    user_id = @book.user.id
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @books = @user.books
  end

   private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
