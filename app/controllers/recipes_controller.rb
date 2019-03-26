class RecipesController < ApplicationController

    #Create
    def new
      @recipe = Recipe.new
      @glasses = Recipe.glasses
      @categories = Recipe.categories
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

end
