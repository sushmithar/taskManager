class Api::V1::TasksController < ApplicationController
  before_action :fetch_task, only: %i[ update destroy]
  def index
    @tasks = Task.all
    render json: {
      status: 200,task: @tasks
    }
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render json: {
        status: 200, task: @task
      }
    else
      render json:  {
          status: 400, error: @task.errors.full_messages
        }
    end
  end

  def update
    if @task.update(task_params)
      render json: {
        status: 200, task: @task
      }
    else
      render json:  {
        status: 400, error: @task.errors.full_messages
      }
    end
  end

  def show
    begin
      @task = Task.find(params[:id])
      render json: {
        status: 200, task: @task
      }
    rescue ActiveRecord::RecordNotFound => exp
      render json: {
        status: 404, error: exp
      }
    end
  end

  def destroy
    if @task.destroy
      render json: {
        status: 200, task: @task
      }
    else
      render json:  {
        status: 400, error: @task.errors.full_messages
      }
    end
  end

  def fetch_tasks
    begin
      if params[:status].present? && params[:user_id].present?
        @tasks = Task.fetch_tasks_by_status(params[:status], params[:user_id])
        render json: @tasks
      end
    rescue ActiveRecord::RecordNotFound => exp
      render json: {
        status: 400, error: exp
    }
  end

  def fetch_task_status
    @statuses = Task::TaskStatuses
  end

  private
    
  def task_params
    params.require(:task).permit(:title, :description, :status, :user_id)
  end

  def fetch_task
    @task = Task.find(params[:id])
  end
end
