class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[show]

  def show
    # @status = @todo.status == false ? "Pending" : "Completed"
    @todo = authorize Todo.find(params[:id])
    @previous_todo = Todo.where("id < ? AND user_id = ? AND status = ?", @todo.id, current_user.id, false).order(id: :desc).first
    @next_todo = Todo.where("id > ? AND user_id = ? AND status = ?", @todo.id, current_user.id, false).order(id: :asc).first

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

    # if @todo.save
    #   redirect_to @todo, notice: 'Todo was successfully created. 🟢'
    # else
    #   render 'new', notice: 'Todo was not created. 🔴'
    # end

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
      @todo.status = true
      @todo.save!
      redirect_to root_path, notice: 'Todo was successfully completed. 🟢'
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
    @todos = Todo.where(status: true)
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
