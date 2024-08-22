class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    redirect_to new_user_session_path unless user_signed_in?
    
    if current_user && Todo.any?

      # Count todos
      @todos_uncompleted = policy_scope(Todo).where(status: false, user_id: current_user.id).count
      @todos_completed = policy_scope(Todo).where(status: true, user_id: current_user.id).count

      # Sort todos
      @todos = policy_scope(Todo).where(status: false)
      @todos_default = @todos.order(created_at: :desc)

      case params[:sort_by]
      when "created_at_asc"
        @todos = @todos.order(created_at: :asc)
      when "created_at_desc"
        @todos = @todos.order(created_at: :desc)
      when "title_asc"
        @todos = @todos.order(title: :asc)
      when "title_desc"
        @todos = @todos.order(title: :desc)
      else
        @todos = @todos_default
      end
    end

    @todos = @todos&.page(params[:page])&.per(7)

    # Devise login
    @resource = User.new
    @resource_name = :user
    @devise_mapping = Devise.mappings[:user]
  end
end
