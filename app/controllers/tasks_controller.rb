# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
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

  def search_title
    @tasks = if params[:title].present?
               Task.where('title LIKE ?', "%#{params[:title]}%")
             else
               Task.none
             end
  end

  def search_status
    @tasks = if params[:status].present?
               Task.where('cast(status as text) LIKE ?', "%#{params[:status]}%")
             else
               Task.none
             end
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'タスクを登録しました。'
      redirect_to tasks_path
    else
      flash[:alert] = 'タスクの登録が失敗しました。'
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
      flash[:notice] = 'タスクを変更しました。'
    else
      flash[:alert] = 'タスクの変更に失敗しました。'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path
      flash[:notice] = 'タスクを削除しました。'
    else
      flash[:alert] = 'タスクの削除に失敗しました。'
      redirect_to tasks_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :text, :deadline, :status, :priority)
  end
end
