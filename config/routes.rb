Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'application#homepage'
  resources :addresses, :users, :products, :drink_types

  #Creating and renaming the main session's paths
  resource :sessions
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out

end
