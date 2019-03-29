require 'json'


path = Rails.root + "db/seed_files/iba_recipes.json"

Recipe.destroy_all
Ingredient.destroy_all
RecipeIngredient.destroy_all
User.destroy_all

recipes = JSON.parse(File.read(path))
recipes.each do |recipe|
  new_recipe = Recipe.create(name: recipe["name"], glass_type: recipe["glass"], category: recipe["category"], instructions: recipe["preparation"])
  recipe["ingredients"].each do |ingredient|
    if ingredient["ingredient"] != nil
      if ingredient["label"] != nil
        name = ingredient["ingredient"] + " - (#{ingredient["label"]})"
      else
        name = ingredient["ingredient"]
      end
      recipe_ing = Ingredient.find_or_create_by(name: name, ingredient_type: "Main ingredient")
      RecipeIngredient.create(recipe_id: new_recipe.id, ingredient_id: recipe_ing.id, amount: ingredient["amount"])
    elsif ingredient["special"] != nil
      recipe_ing = Ingredient.find_or_create_by(name: ingredient["special"], ingredient_type: "Special ingredient")
      RecipeIngredient.create(recipe_id: new_recipe.id, ingredient_id: recipe_ing.id, amount: 1)
    end
  end
end
25.times do
  User.create(
    username: Faker::Name.name,
    first_name: Faker::Name.first_name,
    #password_digest: SecureRandom.alphanumeric(8)
    password_digest: Faker::Internet.password(8)
  )
  end

adam = User.create(username: "Adam1", first_name: "Adam")
adam.password = "password"
adam.save

hema = User.create(username: "Hema", first_name: "Hema")
hema.password = "password"
hema.save

User.all.each do |user|
  rand(5).times do
    ing = Ingredient.all.sample
    UserIngredient.find_or_create_by(user: user, ingredient: ing)
  end
  rand(5).times do
    rec = Recipe.all.sample
    UserRecipe.find_or_create_by(user: user, recipe: rec)
  end
end
