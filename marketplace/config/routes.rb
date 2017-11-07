Rails.application.routes.draw do
  devise_for :users
  resources :lojas

  get 'teste/initialize'
  #resources :teste
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
