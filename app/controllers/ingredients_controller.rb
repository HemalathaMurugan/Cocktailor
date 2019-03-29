class IngredientsController < ApplicationController

  #before_action :define_current_ingredient
  #Create
  def new
    @errors = flash[:errors] || {}
    @ingredient = Ingredient.new
  end

  def create
    ingredient = Ingredient.new(ingredient_params)
    if ingredient.valid?
      ingredient.save
      redirect_to ingredient
    else
      flash[:errors] = ingredient.errors.messages
      #flash[:ingredient_attributes] = ingredient.attributes
      redirect_to new_ingredient_path
    end
  end

  #Read
  def index
    @main_ingredients = Ingredient.main_ingredients
    @special_ingredients = Ingredient.special_ingredients

  end

  def show
    @ingredient = Ingredient.find(params[:id])
    @recipes = @ingredient.recipes
  end

  #Update
  def edit
  end

  def update
  end

  #Destroy
  def destroy
  end

  def search
    search_term = params.permit(:q)[:q]
    @ingredients = Ingredient.search(search_term)
    @main_ingredients = Ingredient.main_ingredients & @ingredients
    @special_ingredients = Ingredient.special_ingredients & @ingredients

    render :index
  end

  def add_ingredient
    @ingredient = Ingredient.find(params[:id])
    UserIngredient.create(user: @user, ingredient: @ingredient)
    redirect_to @ingredient
  end


  private

    #strong params
    def ingredient_params
      params.require(:ingredient).permit(:name, :ingredient_type)
    end
end
