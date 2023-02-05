class UsersController < ApplicationController
  def show
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
  end

  def update
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "It was successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to new_user_session_path
    end
    @users = User.all
    @user = current_user
    @book = Book.new
  end

   private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
