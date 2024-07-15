Rails.application.routes.draw do
  devise_for :users

  get "todos", to: "todos#create", as: "todos"
  get "todos/new", to: "todos#new", as: "new_todo"
  get "todos/:id/edit", to: "todos#edit", as: "edit_todo"
  get "todos/:id", to: "todos#show", as: "todo"
  get "completed", to: "todos#completed", as: :completed_todos
  patch "todos/:id", to: "todos#update"
  put "todos/:id", to: "todos#update"
  post "todos", to: "todos#create"
  delete "todos/:id", to: "todos#destroy"

  get "up" => "rails/health#show", as: :rails_health_check
  get "users/:id/profile", to: "users#show", as: :user_profile

  root to: "pages#home"
end
