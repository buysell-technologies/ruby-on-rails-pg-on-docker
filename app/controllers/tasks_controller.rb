class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    task = params[:task].permit(:title, :description)
    Task.create(task)
    redirect_to root_path, notice: "タスク「#{task.title}」を登録しました"
  end

  def edit
  end

end
