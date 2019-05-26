Rails.application.routes.draw do
  resources :dealers
  resources :stories
  root 'dealers#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
