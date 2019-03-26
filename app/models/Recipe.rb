class Recipe < ActiveRecord::Base

  def self.glasses
    glasses_groups = Recipe.all.group_by{|r| r.glass_type}
    glasses = glasses_groups.map{|k,v| v.first}
  end

  def self.categories
    category_groups = Recipe.all.group_by{|r| r.category}
    categories = category_groups.map{|k,v| v.first}
  end


end
