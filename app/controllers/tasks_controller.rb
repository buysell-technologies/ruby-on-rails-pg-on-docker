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

  def create
    task = params[:task].permit(:title, :description)
    Task.create(task)
    redirect_to root_path, notice: "タスク「#{task.title}」を登録しました。"
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update(params[:task].permit(:title, :description))
    redirect_to root_path, notice: "タスク「#{task.title}」を更新しました。"
  end

end
