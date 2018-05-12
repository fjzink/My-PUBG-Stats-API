Rails.application.routes.draw do
  resources :users

  get '/pubg/seasons', to: 'pubg#seasons'
  get '/pubg/player', to: 'pubg#player'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
