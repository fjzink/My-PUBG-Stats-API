Rails.application.routes.draw do
  resources :users

  get '/pubg/seasons', to: 'pubg#seasons'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
