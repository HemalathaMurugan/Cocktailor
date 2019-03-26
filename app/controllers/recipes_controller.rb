class RecipesController < ApplicationController

    #Create
    def new
      @recipe = Recipe.new
      @recipe_ingredients = nil
      @glasses = Recipe.glasses
      @categories = Recipe.categories
    end

    def create
      if params[:commit] == "Add Ingredient"
        @recipe = Recipe.create(recipes_params(:name, :description, :instructions, :glass_type, :category))
        #@recipe.id = 1
        @ingredient = Ingredient.find_or_create_by(name: recipes_params(ingredients: {})["ingredients"]["ingredient_name"])
        rec_ing = RecipeIngredient.create(recipe: @recipe, ingredient: @ingredient, amount: recipes_params(ingredients: {})["ingredients"]["amount"])
        @recipe_ingredients = @recipe.recipe_ingredients
        @glasses = Recipe.glasses
        @categories = Recipe.categories
        byebug
        render :new
      else
      end

    end

    #Read
    def index
      @recipes = Recipe.all
    end

    def show
      @recipe = Recipe.find(params[:id])
    end

    #Update
    def edit
      @recipe = Recipe.find(params[:id])
      @glasses = Recipe.glasses
      @categories = Recipe.categories
    end

    def update
    end

    #Destroy
    def destroy
      @recipe = Recipe.find(params[:id])
      @recipe.destroy
    end

    private

    def recipes_params(*args)
      params.require(:recipe).permit(*args)
    end

end
