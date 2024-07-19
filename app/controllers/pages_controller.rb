class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user && Todo.any?
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
      @todos_completed = policy_scope(Todo).where(status: true).count
    end
  end
end
