require 'json'

path = "/Users/flatironschool/Development/projects/2-Module/cocktail_recipe_site/db/seed_files/iba_recipes.json"

Recipe.destroy_all
Ingredient.destroy_all
RecipeIngredient.destroy_all

recipes = JSON.parse(File.read(path))
recipes.each do |recipe|
  #byebug
  new_recipe = Recipe.create(name: recipe["name"], glass_type: recipe["glass"], category: recipe["category"], instructions: recipe["preparation"])
  recipe["ingredients"].each do |ingredient|
    if ingredient["ingredient"] != nil
      recipe_ing = Ingredient.find_or_create_by(name: ingredient["ingredient"])
      RecipeIngredient.create(recipe_id: new_recipe, ingredient_id: recipe_ing, amount: ingredient["amount"])
    else
    end
  end
end
