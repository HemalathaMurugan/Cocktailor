class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :user_ingredients
  has_many :users, through: :user_ingredients

  validates :name, uniqueness: true

  def amount
    self.recipe_ingredient.amount
  end

  def amount=(amt)
    self.recipe_ingredient.amount = amt

  def self.main_ingredients
    Ingredient.all.select{|i| i.ingredient_type == "Main ingredient"}
  end

  def self.special_ingredients
    Ingredient.all.select{|i| i.ingredient_type == "Special ingredient"}
  end

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

  def self.all_names
    Ingredient.all.map{|i| [i, i.name.downcase]}
  end

  def self.search(search_term)
    results = []
    Ingredient.all_names.each do |ing|
      if ing[1].include?(search_term)
        results << ing[0]
      end
    end
    results != [] ? ingredients = results : ingredients = Ingredient.all
    return ingredients
  end

  def self.popularity
    Ingredient.all.sort_by{|r| r.recipes.size}.reverse
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
