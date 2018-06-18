class TasksController < ApplicationController

  before_action :signed_in_user
  before_action :belong_to, only: [:show, :destroy, :edit, :update]

  def index
    @tasks = current_user.tasks.paginate(per_page: 5, page: params[:page])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def update

    if @task.update(task_params)
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.required(:task).permit(:title, :description, :due_date, :priority, :finished)
  end

  def signed_in_user
    redirect_to signin_url if current_user.nil?
  end

  # AS we don't have admin we block task for other users
  def belong_to
    @task = Task.find(params[:id])
    redirect_to root_path, notice: "No Access" unless current_user.tasks.exists?(params[:id])
  end
end
