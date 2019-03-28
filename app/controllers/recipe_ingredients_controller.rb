class RecipeIngredientsController < ApplicationController


  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe = @recipe_ingredient.recipe
    @recipe_ingredient.destroy

    redirect_to @recipe
  end



end
