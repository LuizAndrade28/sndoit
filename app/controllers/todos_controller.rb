class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[show]

  def show
    # Get todo
    @todo = authorize Todo.find(params[:id])

    # Navigate to previous todo or to next todo
    @previous_todo = Todo.where("id < ? AND user_id = ? AND status = ?", @todo.id, current_user.id, false).order(id: :desc).first
    @next_todo = Todo.where("id > ? AND user_id = ? AND status = ?", @todo.id, current_user.id, false).order(id: :asc).first

    # Get subtodos
    @subtodos = policy_scope(Subtodo).where(todo: @todo)
    @subtodo = @todo.subtodos.new
  end

  def new
    @todo = Todo.new
    authorize @todo
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    @todo.status = false

    authorize @todo

    respond_to do |format|
      if params[:confirm].present? && @todo.save!
        format.html { redirect_to @todo, notice: 'Todo was successfully created. 🟢' }
      elsif params[:confirm_and_subtodo].present? && @todo.save!
        format.html { redirect_to new_todo_subtodo_path(@todo), notice: 'Todo was successfully created. 🟢' }
      else
        format.html { render :new, notice: 'Todo was not created. 🔴' }
      end
    end
  end

  def edit
  end

  def update
    if params[:complete].present?
      # Complete todo and subtodos
      @todo.status = true
      if @todo.save!
        @todo.subtodos.each do |subtodo|
          subtodo.status = true
          subtodo.save!
        end
      end
      redirect_to root_path, notice: 'Todo was successfully completed. 🟢'
    elsif params[:uncomplete].present?
      # Restore todo and subtodos
      @todo.status = false
      @todo.save!
      redirect_to todo_path(@todo)
    elsif @todo.update(todo_params)
      redirect_to @todo, notice: 'Todo was successfully updated. 🟢'
    else
      render 'edit', notice: 'Todo was not updated. 🔴'
    end
  end

  def destroy
    @todo.destroy
    redirect_to root_path, notice: 'Todo was successfully deleted. 🟢'
  end

  def completed
    # Get completed todos
    @todos = policy_scope(Todo).where(status: true)
    # Paginate todos
    @todos = @todos.page(params[:page]).per(6)

    authorize @todos
  end

  private
  def set_todo
    @todo = Todo.find(params[:id])
    authorize @todo
  end

  def todo_params
    params.require(:todo).permit(:title, :importance, :notes)
  end
end
