class IngredientsController < ApplicationController

  #before_action :define_current_pet
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
    @main_ingredients = Ingredient.all.select{|i| i.ingredient_type == "Main ingredient"}
    @special_ingredients = Ingredient.all.select{|i| i.ingredient_type == "Special ingredient"}

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

  #strong params
  def ingredient_params
    params.require(:ingredient).permit(:name, :ingredient_type)

  end
end
