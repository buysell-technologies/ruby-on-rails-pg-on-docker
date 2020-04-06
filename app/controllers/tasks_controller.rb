class TasksController < ApplicationController
  def index
    keywords = params.dig(:q, :keywords_cont_all)&.split(/[[:space:]]/)
    params[:q][:keywords_cont_all] = keywords if keywords
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page])
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update(task_params)
    redirect_to task, notice: "タスク「#{task.title}」を更新しました。"
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.title}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :important, :status, :deadline_date)
  end

  def search_params
    params.require(:q).permit!
  end

end
