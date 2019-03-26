Rails.application.routes.draw do
  resources :recipes, only: [:new, :show, :index, :edit, :update, :destroy]
  post '/recipes/new', to: 'recipes#create'
  resources :users
  resources :ingredients
  #post '/recipes/add_ingredient', 'recipes#add_ingredient'
end
