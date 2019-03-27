class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, uniqueness: true


  def amount
    self.recipe_ingredients.first ? self.recipe_ingredients.first.amount : nil
  end

  def amount=(recipe: recipe, amount: amount)
    byebug
    rec_ing = self.recipe_ingredients.select {|r_i| r_i.recipe == recipe}
    rec_ing.amount = amount
  end
end
