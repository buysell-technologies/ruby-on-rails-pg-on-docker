class UsersController < ApplicationController
    before_action :authenticate, only: [:show]
    def show
        # もっとうまいやり方がありそう
        if @auth_user.id == params[:id].to_i
          @user = User.find(params[:id])
          render json: { status: 'SUCCESS', data: @user }
        else
          render json: { status: 'ERROR', data: "" }
        end
    end
    # ステータスコードが400で返す
    def create
        @user = User.new(user_params)
        if @user.save
          render json: { status: 'SUCCESS', data: @user }
        else
          render json: { status: 'ERROR',data: @user.errors}, status: 400
        end
    end

    private

    def user_params
        # 通らない
        # params.require(:user).permit(:name,:email,:password)
        params.permit(:name,:email,:password)
    end
end
