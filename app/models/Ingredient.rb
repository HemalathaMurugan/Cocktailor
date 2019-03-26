class Ingredient < ActiveRecord::Base
  validates :name, uniqueness: true

end
