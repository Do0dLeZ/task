class TasksController < ApplicationController

  before_action :signed_in_user

  def index
    @tasks = Task.paginate(per_page: 5, page: params[:page])
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path
  end

  private

  def task_params
    params.required(:task).permit(:title, :description, :due_date)
  end

  def select_tasks
    @tasks = Task.all
  end

  def signed_in_user
    redirect_to signin_url if current_user.nil?
  end
end
