class RelationTaskLabelController < ApplicationController
  before_action :authenticate
  def create
    # ラベルがデータベースになければ作成．あれば参照
    @label = Label.find(params[:label_id])
    @task.add_label(@label)
    # 何を返せばいいかよくわからない
    render json: @task
  end

  def destroy
    # ラベルがデータベースになければ作成．あれば参照
    @label = Label.find(params[:label_id])
    @task.delete_label(@label)
    # 何を返せばいいかよくわからない
    render json: @task
  end
end
