class UsersController < ApplicationController
  #before_action :require_login
  #skip_before_action :require_login, only: [:index]
  #skip_before_action :authenticate, only [:new, :create]

  
  #Create
  def new
    #@errors = flash[:errors] || {}
    @user = User.new
  end

  def create
    user = User.new(user_params[:user])
    if user.valid?
        user.save
        flash[:notice] = "You signed up successfully!"
        flash[:color] = "valid"
        #redirect_to '/users'
    else
      flash[:notice] = "Try a different name"
      flash[:color] = "invalid"
      #redirect_to new_user_path
    end
    render "new"
  end

  #Read
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  #Update
  def edit
    @user = User.find(params[:id])
    if(flash[:user_attributes])
      @user.assign_attributes(flash[:user_attributes])
      @user.valid?
    end
    @errors = @user.errors.messages
    @user = User.all
  end

  def update
    user = User.find(params[:id])
    user.assign_attributes(user_params[:user])
    if user.valid?
      user.save
    else
      flash[:user_attributes] = user.attributes
    end
    redirect_to user
    
  end

  #Destroy
  def destroy
    # @user = User.find(params[:id])
    # @user.destroy
    # redirect_to '/users'
  end

  def user_params
    params.require(:user).permit(:user_name,:password, :password_confirmation, :password_digest, :first_name)
  end
end
