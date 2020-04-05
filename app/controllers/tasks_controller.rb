class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        @tasks = Task.all
        render json: @tasks
    end
  
    def show
        render json: @task
    end

    # curl -X POST -H "Content-Type: application/json" -d '{"name":"test title 200","content":"test content text200","label":"test label","status":0,"deadline":"2020-04-07T00:15:46.020+09:00","priority":2}' http://0.0.0.0/tasks
    def create
        # ストロングパラメータによるフィルタに通す(before_actionに記載)
        @task = Task.new(task_params)

        if @task.save
            render json: {status: "create task",data: @task}
          else
            render json: {status:unprocessable_entity,data: @task.errors}
          end
    end

    # curl -X PUT -H "Content-Type: application/json" -d '{"name":"test title 200","content":"test content text200","label":"test label","status":0,"deadline":"2020-04-07T00:15:46.020+09:00","priority":2}' http://0.0.0.0/tasks
   def update
        if @task.update(task_params)
            render json: {status: "update task",data: @task}
        else
            render {status:unprocessable_entity,data: @task.errors}
        end
    end
  
    def destroy
        @task.destroy
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
