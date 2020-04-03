class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
  
    def show
        @task = Task.find(params[:id])
    end
  
    def new
        #デフォルト値を指定する場合ここに記載
        @task = Task.new
    end
  
    def create
        # ストロングパラメータによるフィルタに通す
        @task = Task.new(task_params)

        if @task.save
            flash[:success] = 'タスク作成完了'
            redirect_to @task
          else
            # renderはnewアクションを実行せずに移動
            flash[:danger] = 'タスク作成失敗!!!!'
            render :new
          end
    end
  
    def edit
        @task = Task.find(params[:id])
    end
  
    def update
        @task = Task.find(params[:id])

        if @task.update(task_params)
            flash[:success] = 'タスク更新完了'
            redirect_to @task
        else
            flash[:success] = 'タスク更新失敗!!!!'
            render :edit
        end
    end
  
    def destroy
        @task = Task.find(params[:id])
        @task.destroy

        redirect_to tasks_url
    end

    # セキュリティ対策
    private
    def task_params
        params.require(:task).permit(:name,:content,:label,:status,:deadline,:priority)
    end
end
