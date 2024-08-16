class SubtodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo
  before_action :set_subtodo, only: %i[edit update destroy]

  def new
    @subtodo = @todo.subtodos.new
    authorize @subtodo
  end

  def create
    @subtodo = @todo.subtodos.new(subtodo_params)
    @subtodo.status = false
    @subtodo.user_id = current_user.id

    authorize @subtodo

    respond_to do |format|
      if params[:confirm].present? && @subtodo.save
        format.html { redirect_to todo_path(@todo), notice: 'Subtodo was successfully created. 🟢' }
      elsif params[:confirm_and_new].present? && @subtodo.save
        format.html { redirect_to new_todo_subtodo_path(@todo), notice: 'Subtodo was successfully created. 🟢' }
      elsif params[:finish].present?
        format.html { redirect_to todo_path(@todo) }
      else
        format.html { render :new, notice: 'Subtodo was not created. 🔴' }
      end
    end
  end

  def edit
  end

  def update
    if params[:complete].present?
      # Complete subtodo
      @subtodo.status = true
      @subtodo.save!
      redirect_to todo_path(@todo), notice: 'Subtodo was successfully finished. 🟢'
    elsif params[:uncomplete].present?
      # Restore subtodo
      @subtodo.status = false
      @subtodo.save!
      redirect_to todo_path(@todo), notice: 'Subtodo was successfully restored. 🟢'
    elsif @subtodo.update(subtodo_params)
      # Edit and update subtodo
      redirect_to todo_path(@todo), notice: 'Subtodo was successfully updated. 🟢'
    else
      render 'edit', notice: 'Subtodo was not updated. 🔴'
    end
  end

  def destroy
    @subtodo.destroy!
    redirect_to todo_path(@todo), notice: 'Subtodo was successfully deleted!'
  end

  private

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_subtodo
    @subtodo = @todo.subtodos.find(params[:id])
    authorize @subtodo
  end

  def subtodo_params
    params.require(:subtodo).permit(:title)
  end
end
