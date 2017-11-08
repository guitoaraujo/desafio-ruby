Rails.application.routes.draw do
  resources :produtos
  devise_for :users
  resources :lojas

  root 'produtos#index'

  get 'teste/initialize'
  #resources :teste
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
