Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "checkout#index"


  get '/checkout/add', to: 'checkout#add_to_cart'
  get '/checkout/reset', to: 'checkout#reset_cart'


end
