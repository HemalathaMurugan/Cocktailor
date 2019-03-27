class RecipesController < ApplicationController

    #Create
    def new
      @recipe = Recipe.new
      6.times { @recipe.ingredients.build }
      @glasses = Recipe.glasses
      @categories = Recipe.categories
      @ingredients = Ingredient.all
    end

    def create
      byebug
      @recipe = Recipe.new(recipes_params(:name, :description, :instructions, :glass_type, :category))
      recipes_params(ingredients_attributes: [:name, :amount])["ingredients_attributes"].each do |i_a|
        @ing = Ingredient.find_or_create_by(name: i_a[1]["name"])
        @r_c = RecipeIngredient.create(recipe: @recipe, ingredient: @ing, amount: i_a[1]["amount"])
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
      @user = User.find(session[:current_user_id])
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

    def search
      search = params.permit(:q)[:q]
      results = []
      Recipe.all_names.each do |rec|
        if rec.include?(search)
          results << Recipe.find_by(name: rec.titleize)
        end
      end
      if results != []
        @recipes = results
      else
        @recipes = Recipe.all
      end
      render :index
    end


    def add_recipe
      @recipe = Recipe.find(params[:id])
      @user = User.find(session[:current_user_id])
      UserRecipe.create(user: @user, recipe: @recipe)
      #@recipes = @ingredient.recipes
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
