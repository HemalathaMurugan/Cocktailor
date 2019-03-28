class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  def ingredient_name
    self.ingredient ? self.ingredient.name : nil
  end
end
