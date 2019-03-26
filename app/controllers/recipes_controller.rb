class RecipesController < ApplicationController

    def new
        @recipe = Recipe.new
        @glasses = Recipe.glasses
        @categories = Recipe.categories


    end

end
