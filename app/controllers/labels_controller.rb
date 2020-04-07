class LabelsController < ApplicationController
    before_action :set_label, only: [:show, :update, :destroy]
    before_action :authenticate
    before_action :check_user, only: [:show,:update,:destroy]

    def index
        @labels = Label.includes(@user)
        render json: @labels
    end
  
    def show
        render json: @label
    end

    # curl -X POST -H "Content-Type: application/json" -d '{"name":"test label"}'
    def create
        # ストロングパラメータによるフィルタに通す(before_actionに記載)
        @label = Label.new(label_params)

        if @label.save
            render json: {status: "create label",data: @label}
          else
            render json: {status:unprocessable_entity,data: @label.errors}
          end
    end

    # curl -X PUT -H "Content-Type: application/json" -d '{"name":"test label update"}'
    def update
        if @label.update(label_params)
            render json: {status: "update label",data: @label}
        else
            render {status:unprocessable_entity,data: @label.errors}
        end
    end
  
    def destroy
        @label.destroy
    end

    private

    def set_label
        @label = Label.find(params[:id])
    end

    # セキュリティ対策(ストロングパラメータ)
    def label_params
        params.require(:label).permit(
            :name
        )
    end
end
