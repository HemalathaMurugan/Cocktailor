class RecipesController < ApplicationController
    skip_before_action :authenticate, only: [:index]
    
    #Create
    def new
      @recipe = Recipe.new
      6.times { @recipe.recipe_ingredients.build }
      @glasses = Recipe.glasses
      @categories = Recipe.categories
      @ingredients = Ingredient.all
    end

    def create
      @recipe = Recipe.new(recipes_params(:name, :description, :instructions, :glass_type, :category))
      r_i_params = recipes_params(recipe_ingredient: {})["recipe_ingredient"]
      @recipe.set_recipe_ingredients(r_i_params)
      redirect_to @recipe
    end

    #Read
    def index
      @recipes = Recipe.all
    end

    def show
      @recipe = Recipe.find(params[:id])
      @ingredients = @recipe.ingredients
    end

    #Update
    def edit
      @recipe = Recipe.find(params[:id])
      @glasses = Recipe.glasses
      @categories = Recipe.categories
      @ingredients = Ingredient.all
      @recipe.recipe_ingredients.build
    end

    def update
      @recipe = Recipe.find(params[:id])
      @recipe.assign_attributes(recipes_params(:name, :description, :instructions, :glass_type, :category))
      r_i_params = recipes_params(recipe_ingredient: {})["recipe_ingredient"]
      @recipe.set_recipe_ingredients(r_i_params)
      @recipe.save
      redirect_to @recipe
    end

    #Destroy
    def destroy
      @recipe = Recipe.find(params[:id])
      @recipe.destroy
    end

    def search
      search_term = params.permit(:q)[:q]
      @recipes = Recipe.search(search_term)
      render :index
    end

    def rate_this_recipe
      @recipe = Recipe.find(params[:id])
      @recipe.update(rating: params)
    end

    def add_recipe
      @recipe = Recipe.find(params[:id])
      UserRecipe.create(user: @user, recipe: @recipe)
      redirect_to @recipe
    end

    def add_ingredients
      @recipe = Recipe.find(params[:id])
      @recipe.add_ingredients(@user)
      redirect_to @user
    end

    private

      def recipes_params(*args)
        params.require(:recipe).permit(*args)
      end
end
