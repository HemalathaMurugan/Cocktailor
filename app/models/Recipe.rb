class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipes
  has_many :users, through: :user_recipes

  validates :name, uniqueness: true
  validates :name, presence: true
  validate :check_rating
  before_save :titleize_glasses, :fix_nil_in_categories, :titleize_names

  def check_rating
    if self.rating <=5 && self.rating >=1
    elsif self.rating == nil
    else
      errors.add(:rating, "Rating must be a number between 1 and 5.")
    end
  end

  def titleize_glasses
    self.glass_type = self.glass_type.titleize
  end

  def fix_nil_in_categories
    if self.category == nil
      self.category = 'Uncategorized'
    end
  end

  def titleize_names
    self.name = self.name.titleize
  end

  def self.glasses
    glasses_groups = Recipe.all.group_by{|r| r.glass_type}
    glasses = glasses_groups.map{|k,v| v.first}.sort_by{|r| r.glass_type}
  end

  def self.categories
    category_groups = Recipe.all.group_by{|r| r.category}
    categories = category_groups.map{|k,v| v.first}.sort_by{|r| r.category}
  end

  def self.ingredient_lists
    Recipe.all.map{|r| [r, r.ingredients]}
  end

  def user_count
    user_count = 0
    ur_s = UserRecipe.all
    ur_s.each do |ur|
      if ur.recipe_id == self.id
        user_count +=1
      end
    end
    user_count
  end


  


  # def user_rating(params)
  #   user_rating = 0
    
  #   ur_s = UserRecipes.all
  #   ur_s.each do |ur|
  #     if ur.recipe_id == self.id
  #       user_id = ur.user_id
      



  # end



  def self.all_names
    Recipe.all.map{|r| [r, r.name.downcase]}
  end

  def self.search(search_term)
    results = []
    Recipe.all_names.each do |rec|
      if rec[1].include?(search_term)
        results << rec[0]
      end
    end
    results != [] ? recipes = results : recipes = Recipe.all
    return recipes
  end

  def self.popularity
    Recipe.all.sort_by{|r| r.users.size}.reverse
  end

  def add_ingredients(user)
    byebug
    self.ingredients.each do |ing|
      if ing.ingredient_type == "Main ingredient"
        UserIngredient.find_or_create_by(user: user, ingredient: ing)
      end
    end
  end

  def set_recipe_ingredients(params)
    params.each do |i_a|
      if i_a[1]["ingredient_name"] != ''
        @ing = Ingredient.find_or_create_by(name: i_a[1]["ingredient_name"])
        if i_a[1]["amount"] != "0"
          @ing.ingredient_type = "Main ingredient"
        else
          @ing.ingredient_type = "Special ingredient"
        end
        @ing.save
        @r_c = RecipeIngredient.find_or_create_by(recipe: self, ingredient: @ing)
        if i_a[1]["amount"] != ""
          @r_c.update(amount: i_a[1]["amount"])
        else
          @r_c.destroy
        end
      end
    end
  end

end
