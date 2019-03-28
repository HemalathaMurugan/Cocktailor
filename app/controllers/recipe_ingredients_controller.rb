class RecipeIngredientsController < ApplicationController


  def destroy
    byebug
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe = @recipe_ingredient.recipe
    @recipe_ingredient.destroy

    redirect_to @recipe
  end



end
