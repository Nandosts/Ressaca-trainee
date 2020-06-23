Rails.application.routes.draw do
  root 'application#homepage'
  resource :addresses, :users, :products, :user_sessions

  scope 'user' do
    get 'login', to: 'user_sessions#new', as: :login
    post 'login', to: 'user_sessions#create'
    post 'logout', to: 'user_sessions#destroy', as: :logout
  end
end
