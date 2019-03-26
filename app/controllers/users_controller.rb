class UsersController < ApplicationController

  #Create
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    redirect_to user
  end

  #Read
  def index
    @users = User.all
  end

  def show
    @user = User.find(paramas[:id])
  end

  #Update
  def edit
    @user = User.find(params[:id])
  
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user
  end

  #Destroy
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def user_params
    params.require(:user).permit(:user_name, :password_digest)
  end
end
