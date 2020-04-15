class TasksController < ApplicationController
    before_action :set_task, only: [:show, :update, :destroy, :labels,:create_label]
    before_action :authenticate
    before_action :check_user, only: [:show,:update,:destroy,:labels]

    def index
        @tasks = @auth_user.tasks.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'index tasks', data: @tasks }
    end
  
    def show
        render json: { status: 'SUCCESS', message: 'show tasks', data: @task }
    end

    # curl -X POST -H "Content-Type: application/json" -d '{"name":"test title 200","content":"test content text200","label":"test label","status":0,"deadline":"2020-04-07T00:15:46.020+09:00","priority":2}' http://0.0.0.0/tasks
    def create
        @task = Task.new(task_params)
        @task.update(user_id: @auth_user.id)

        if @task.save
            render json: { status: 'SUCCESS', data: @task }
        else
            render json: { status: 'ERROR', data: @task.errors }
        end
    end

    # curl -X PUT -H "Content-Type: application/json" -d '{"name":"test title 200","content":"test content text200","label":"test label","status":0,"deadline":"2020-04-07T00:15:46.020+09:00","priority":2}' http://0.0.0.0/tasks
    def update
        if @task.update(task_params)
            render json: { status: 'SUCCESS', data: @task }
        else
            render json: { status: 'ERROR', data: @task.errors }
        end
    end
  
    def destroy
        @task.destroy
        render json: { status: 'SUCCESS', message: 'Deleted task'}
    end

    def labels
        @labels = @task.labels
        render json: { status: 'SUCCESS', message: 'Label for this task', data: @labels}
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
            :status,
            :deadline,
            :priority
        )
    end

    def check_user
        if @auth_user.id == @task.user_id
            true
        else
            render json: { status: 'ERROR', message: 'Please login by currect user'}, status: 403
        end
    end
end
