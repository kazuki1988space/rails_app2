class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)
    if @user.save
      redirect_to user_path(@user.id)
    else
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_param
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end