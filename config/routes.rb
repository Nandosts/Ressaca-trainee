Rails.application.routes.draw do
  root 'products#search'
  resources :addresses, :drink_types

  scope 'compras' do
    get 'compra(.:id)', to: 'purchases#show', as: :purchase_show

    get 'cart', to: 'purchases#cart', as: 'cart'
    post 'cart', to: 'purchases#cart_post'

    post 'buy_product(.:id)', to: 'purchase_products#create', as: :buy
    delete 'buy_product(.:id)', to: 'purchase_products#destroy'
    get 'search(.:type)(.:search)', to: 'products#search', as: :search
    post 'update_product(.:id)', to: 'purchase_products#update', as: :update

    get 'buy_cart', to: 'purchases#buy', as: :buy_cart
    get 'ComprasAntigas', to: 'purchases#index', as: :purchases_index
  end

  scope 'user' do
    get 'login', to: 'user_sessions#new', as: :login
    post 'login', to: 'user_sessions#create'

    post 'logout', to: 'user_sessions#destroy', as: :logout

    get 'novo', to: 'users#new', as: :new_user
    post 'novo', to: 'users#create'

    delete '/', to: 'users#destroy'
    get 'perfil(.:id)', to: 'users#show', as: :perfil_user

    get 'money', to: 'users#add_money', as: :money
    post 'money', to: 'users#add_money_logic'
  end

  resources :products do
    member { patch :favorite }
  end
end