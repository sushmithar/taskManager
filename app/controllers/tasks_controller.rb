class TasksController < ApplicationController
  before_action :fetch_task_status, only: %i[index new show create edit update]
    def index
      @tasks = current_user.tasks.all
      @current_user = current_user
    end

    def show
      @task = Task.find(params[:id])
    end

    def new
      @task = Task.new
      render :new
    end

    def create
      @task = Task.new(task_params.merge({user_id: current_user.id}))
      if @task.save
        redirect_to tasks_path
      else
        flash[:notice] = @task.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @task = Task.find(params[:id])
      render :edit
    end

    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to tasks_path
      else
        flash[:notice] = @task.errors.full_messages
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      redirect_to tasks_path, status: :see_other
    end

    def fetch_tasks
      @statuses = Task::TaskStatuses
      @tasks = Task.fetch_tasks_by_status(params[:status], params[:user_id])
      render :index
    end
    

    private
    
    def task_params
      params.require(:task).permit(:title, :description, :status, :user_id)
    end

    def fetch_task
      @task = Task.find(params[:id])
    end

    def fetch_task_status
      @statuses = Task::TaskStatuses
    end
end
