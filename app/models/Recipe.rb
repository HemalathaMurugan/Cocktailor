class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipes
  has_many :users, through: :user_recipes
  accepts_nested_attributes_for :ingredients

  validates :name, uniqueness: true
  validates :name, presence: true
  before_save :titleize_glasses, :fix_nil_in_categories, :titleize_names

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

  def self.all_names
    Recipe.all.map{|r| r.name.downcase}
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

end
