Rails.application.routes.draw do
  devise_for :users

  resources :todos, except: %i[index] do
    resources :subtodos, except: %i[index show]
  end

  get "completed", to: "todos#completed", as: :completed_todos
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
end
