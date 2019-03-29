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
      # recipes_params(ingredients_attributes: [:name, :amount])["ingredients_attributes"].each do |i_a|
      #   if i_a[1]["name"] != ''
      #     @ing = Ingredient.find_or_create_by(name: i_a[1]["name"])
      #     @r_c = RecipeIngredient.find_or_create_by(recipe: @recipe, ingredient: @ing, amount: i_a[1]["amount"])
      #   end
      # end
      recipes_params(recipe_ingredient: {})["recipe_ingredient"].each do |i_a|
        if i_a[1]["ingredient_name"] != ''
          @ing = Ingredient.find_or_create_by(name: i_a[1]["ingredient_name"])
          if i_a[1]["amount"] != ""
            @ing.ingredient_type = "Main ingredient"
          else
            @ing.ingredient_type = "Special ingredient"
          end
          @ing.save
          @r_c = RecipeIngredient.find_or_create_by(recipe: @recipe, ingredient: @ing, amount: i_a[1]["amount"])
        end
      end
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
      #byebug
      @recipe = Recipe.find(params[:id])
      @recipe.assign_attributes(recipes_params(:name, :description, :instructions, :glass_type, :category))

      recipes_params(recipe_ingredient: {})["recipe_ingredient"].each do |i_a|
        if i_a[1]["ingredient_name"] != ''
          @ing = Ingredient.find_or_create_by(name: i_a[1]["ingredient_name"])
          if i_a[1]["amount"] != "0"
            @ing.ingredient_type = "Main ingredient"
          else
            @ing.ingredient_type = "Special ingredient"
          end
          @ing.save
          @r_c = RecipeIngredient.find_or_create_by(recipe: @recipe, ingredient: @ing)
          if i_a[1]["amount"] != ""
            @r_c.update(amount: i_a[1]["amount"])
          else
            @r_c.destroy
          end
        end
      end
      # recipes_params(ingredients_attributes: [:name, :amount])["ingredients_attributes"].each do |i_a|
      #   if i_a[1]["name"] != ''
      #     @ing = Ingredient.find_or_create_by(name: i_a[1]["name"])
      #     @r_c = RecipeIngredient.find_or_create_by(recipe: @recipe, ingredient: @ing, amount: i_a[1]["amount"])
      #   end
      # end
      @recipe.save
      redirect_to @recipe
      #recipes_params(recipe_ingredients: {})["recipe_ingredients"]["ingredient_name"]
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

    private

      def recipes_params(*args)
        params.require(:recipe).permit(*args)
      end


    #
    # def recipes_params
    #   params.require(:recipe).permit(:name, :description, :instructions, :glass_type, :category, ingredients_attributes: [:name, :amount])
    # end
end
