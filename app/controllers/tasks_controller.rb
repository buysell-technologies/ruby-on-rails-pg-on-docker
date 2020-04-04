class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        @tasks = Task.all
    end
  
    def show
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
    end
  
    def update
        if @task.update(task_params)
            flash[:success] = 'タスク更新完了'
            redirect_to @task
        else
            flash[:success] = 'タスク更新失敗!!!!'
            render :edit
        end
    end
  
    def destroy
        @task.destroy

        redirect_to tasks_url
    end

    private

    # 繰り返し除去のために定義。before_actionで使うといちいち記述しなくて良い
    def set_task
        @task = Task.find(params[:id])
    end

    # セキュリティ対策(ストロングパラメータ)
    def task_params
        params.require(:task).permit(
            :name,
            :content,
            :label,
            :status,
            :deadline,
            :priority
        )
    end
end
