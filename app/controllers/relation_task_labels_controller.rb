class RelationTaskLabelsController < ApplicationController
  before_action :set_task
  before_action :authenticate
  before_action :check_user

  def create
    @label = Label.find_or_create_by(name: params[:name])
    # ストロングパラメータはTaskモデル側に定義した
    @task.add_label(@label)
    # 何を返せばいいかよくわからない
    render json: { status: 'SUCCESS', data: @label }
  end

  def destroy
    # ラベルがデータベースになければ作成．あれば参照
    @label = Label.find(params[:label_id])
    @task.delete_label(@label)
    # 何を返せばいいかよくわからない
    render json: { status: 'SUCCESS', message: 'Deleted Label'}
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def label_params
    params.require(:label).permit(
        :name,
    )
  end

  def check_user
    if @auth_user.id == @task.user_id
        true
    else
        render json: { status: 'ERROR', message: 'Please login by currect user'}
    end
  end

end
