class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :user_ingredients
  has_many :users, through: :user_ingredients

  validates :name, uniqueness: true

  def recipe_count
    recipe_count = 0
    
    ri_s = RecipeIngredient.all
    ri_s.each do |ri|
      if ri.ingredient_id == self.id
        recipe_count += 1
      end
    end
    recipe_count
  end


  # def amount(recipe: recipe)
  #   byebug
  #   if self.recipe_ingredients.first
  #     rec_ing = self.recipe_ingredients.select {|r_i| r_i.recipe == recipe}
  #     rec_ing.amount
  #   end
  # end
  #  I think these are obsolete...
  # def amount=(recipe: recipe, amount: amount)
  #   byebug
  #   rec_ing = self.recipe_ingredients.select {|r_i| r_i.recipe == recipe}
  #   rec_ing.amount = amount
  # end
end
