class TasksController < ApplicationController
  def index
    @tasks = Task.order(name: :asc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save if @task.valid?
    redirect_to tasks_path
  end


  def task_params
    params.require(:task).permit(:name)
  end
end