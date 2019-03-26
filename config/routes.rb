Rails.application.routes.draw do
  resources :recipes
  resources :users
  resources :ingredients
end
