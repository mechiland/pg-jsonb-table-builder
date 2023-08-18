Rails.application.routes.draw do
  resources :select_options

  resources :tables do
    resources :columns
    resources :rows
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
