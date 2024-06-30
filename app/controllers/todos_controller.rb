class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[show edit update destroy]

  def show
    authorize @todo
    @todo = Todo.find(params[:id])
    @status = @todo.completed == false ? "Pending" : "Completed"
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    @todo.status = false

    if @todo.save
      redirect_to @todo, notice: 'Todo was successfully created. 🟢'
    else
      render 'new', notice: 'Todo was not created. 🔴'
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: 'Todo was successfully updated. 🟢'
    else
      render 'edit', notice: 'Todo was not updated. 🔴'
    end
  end

  def destroy
    @todo.destroy
    redirect_to root_path, notice: 'Todo was successfully deleted. 🟢'
  end

  private
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :date, :time, :friend_id)
  end
end
