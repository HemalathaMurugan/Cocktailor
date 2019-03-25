class CreateRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |t|
      t.string :amount
      t.belongs_to :recipe
      t.belongs_to :ingredient
    end
  end
end
