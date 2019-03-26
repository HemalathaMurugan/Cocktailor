class UsersController < ApplicationController

  #Create
  def new
    @user = User.new
  end

  def create
  end

  #Read
  def index
  end

  def show
  end

  #Update
  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  #Destroy
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

end
