Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :todos, except: %i[index]

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
end
