class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user && Todo.any?
      @todos = current_user&.todos
    end
  end
end
