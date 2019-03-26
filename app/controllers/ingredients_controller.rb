class IngredientsController < ApplicationController

  #Create
  def new
    @ingredient = Ingredient.new
  end

  def create
    ingredient = Ingredient.create(ingredient_params)
    redirect_to ingredient
  end

  #Read
  def index
    @ingredients = Ingredient.all
    
  end

  def show
    @ingredient = Ingredient.find(params[:id])
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
