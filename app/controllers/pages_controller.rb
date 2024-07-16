class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user && Todo.any?
      @todos = policy_scope(Todo).where(status: false)
      @todos_completed = policy_scope(Todo).where(status: true).count
    end
  end
end
