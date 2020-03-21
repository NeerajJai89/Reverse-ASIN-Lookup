Rails.application.routes.draw do
  resources :products, only: %i[index create show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
