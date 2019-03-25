class CreateUserRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_recipes do |t|
      t.belongs_to :user
      t.belongs_to :recipe
    end
  end
end
