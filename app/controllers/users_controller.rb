class UsersController < ApplicationController
  #before_action :require_login
  #skip_before_action :require_login, only: [:index]
  skip_before_action :authenticate, only: [:new, :create]


  #Create
  def new
    #@errors = flash[:errors] || {}
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
        @user.save
        flash[:notice] = "You signed up successfully!"
        
        redirect_to user_path(@user)
    else
      flash[:alert] = "Invalid username or password! Try again."
      
      render :new

    end
  end

  #Read
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @ingredients = @user.ingredients
    @possible_recipes = @user.possible_recipes
    @recipes = @user.recipes
    if @user
      flash[:notice] = "You are currently logged in as: #{@user.username}"
    else
      #render :new, alert: "Invalid Login! Try again"
      flash[:alert] = "Invalid Login! Try again"
    end
  end

  #Update
  def edit
    @user = User.find(params[:id])
    # if(flash[:user_attributes])
    #   @user.assign_attributes(flash[:user_attributes])
    #   @user.valid?
    # end
    # @errors = @user.errors.messages
    @users = User.all
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
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/sessions/new'
  end



  private

    def user_params
      params.require(:user).permit(:username, :first_name, :password, :password_confirmation)
    end
end
