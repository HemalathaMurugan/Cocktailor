Rails.application.routes.draw do
  resources :recipes, only: [:new, :show, :index, :edit, :update, :destroy]
  post '/recipes/new', to: 'recipes#create'
  resources :users
  resources :ingredients
  resources :sessions
  get '/test_path/:id', to: 'ingredients#add_ingredient'
  #post '/recipes/add_ingredient', 'recipes#add_ingredient'
end
