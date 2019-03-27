Rails.application.routes.draw do
  resources :recipes
  get '/recipes_search', to: 'recipes#search'
  resources :users
  resources :ingredients
  resources :sessions
  #post '/recipes/add_ingredient', 'recipes#add_ingredient'
end
