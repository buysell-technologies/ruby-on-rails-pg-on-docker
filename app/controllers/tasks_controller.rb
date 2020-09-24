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

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスクを登録しました。"
      redirect_to tasks_path
    else
      flash[:alert] = "タスクの登録失敗しました。"
      redirect_to tasks_new_path
    end
  end

  def update
    @task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_path
  end
  

  def destroy
  end

   private 
     def task_params
       params.require(:task).permit(:title, :text, :deadline, :status, :priority)
     end
     
end

