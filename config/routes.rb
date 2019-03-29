Rails.application.routes.draw do
  resources :recipes
  resources :users
  resources :ingredients
  resources :sessions, only: [:new, :create, :index, :show]
  resources :recipe_ingredients, only: [:destroy]

  get '/recipes_search', to: 'recipes#search'
  get '/ingredients_search', to: 'ingredients#search'
  post '/add_recipe/:id', to: 'recipes#add_recipe'
  post '/add_ingredient/:id', to: 'ingredients#add_ingredient'
  delete '/sessions', to: 'sessions#destroy'
end
