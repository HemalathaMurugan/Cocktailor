class User < ActiveRecord::Base
  has_many :user_recipes
  has_many :recipes, through: :user_recipes
  has_many :user_ingredients
  has_many :ingredients, through: :user_ingredients

  has_secure_password

  validates :username, uniqueness: true
  validates :first_name, presence: true

  def possible_recipes
    result = []
    Recipe.ingredient_lists.each do |recipe|
      @list = []
      recipe[1].each do |ing|
        if ing.ingredient_type == "Main ingredient"
          @list << ing
        end
      end
      #byebug
      if (@list - self.ingredients).empty?
        result << recipe[0]
      end
    end
    return result
  end
end
