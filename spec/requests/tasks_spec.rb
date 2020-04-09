require 'rails_helper'

describe 'Taskモデル', type: :request do
    before do
        @headers = {"Content-Type" => 'application/json'}
    end

    context "タスク所持ユーザー本人によるGETリクエスト．" do
        it "ユーザーの所持タスク一覧を取得" do
            @tasks = FactoryBot.create_list(:task,10)
            puts @tasks
            @headers["Authorization"] = "Token " + @user.token
            get '/tasks', headers: @headers
            expect(response.status).to eq(200)
        end
    end

    # トークン所持済みで他のユーザーのタスクへアクセスしようとする場合
end