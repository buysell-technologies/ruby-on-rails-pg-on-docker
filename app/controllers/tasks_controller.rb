class TasksController < ApplicationController
  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.create!(task_params)
    redirect_to task, notice: "タスク「#{task.title}」を登録しました。"
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
    redirect_to task, notice: "タスク「#{task.title}」を更新しました。"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.title}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline_date, :status)
  end

  def search_params
    params.require(:q).permit!
  end

end
