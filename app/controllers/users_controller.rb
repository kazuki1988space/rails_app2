class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)
    if @user.save
      redirect_to new_session_path
    else
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_param)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  private
  def user_param
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
