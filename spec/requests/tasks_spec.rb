require 'rails_helper'

describe 'Taskモデル', type: :request do
    before do
        @headers = {"Content-Type" => 'application/json'}
        @user = FactoryBot.create(:user)
    end

    context "タスク所持ユーザー本人によるGETリクエスト．" do
        it "ユーザーの所持タスク一覧を取得" do
            @tasks = FactoryBot.create_list(:task,10,user: @user)
            @headers["Authorization"] = "Token " + @user.token
            get '/tasks', headers: @headers
            json = JSON.parse(response.body)
            expect(response.status).to eq(200)
            expect(json['data'].length).to eq(10)
        end
        it "ユーザーの特定のタスクを取得" do
            @task = FactoryBot.create(:task,user: @user)
            @headers["Authorization"] = "Token " + @user.token
            get "/tasks/#{@task.id}", headers: @headers
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["data"]["id"]).to eq(@task.id)
        end
    end

    context "トークン所持済みの他ユーザーによるGETリクエスト．" do
        it "他ユーザーの特定のタスクを取得しようとして失敗" do
            @task = FactoryBot.create(:task,user: @user)
            # 他ユーザーの作成とログイン
            @another_user = FactoryBot.create(:user)
            @headers["Authorization"] = "Token " + @another_user.token
            get "/tasks/#{@task.id}", headers: @headers
            expect(response.status).to eq(403)
        end
    end


    context "タスク所持ユーザー本人によるPOSTリクエスト" do
        it "タスク作成．" do
            @headers["Authorization"] = "Token " + @user.token
            task_params = {
                "name":"test title",
                "content":"test content text","status":0,
                "deadline":"2020-04-23T00:15:46.020+09:00",
                "priority":2}
            post "/tasks",params: task_params.to_json,headers: @headers
            expect(response.status).to eq(200)
        end
        it "タスク内容更新．" do
            @headers["Authorization"] = "Token " + @user.token
            @task = FactoryBot.create(:task,user: @user)
            task_params = {
                "name":"update title",
                "content":"test content text","status":0,
                "deadline":"2020-04-23T00:15:46.020+09:00",
                "priority":2}
            put "/tasks/#{@task.id}", params: task_params.to_json, headers: @headers
            expect(response.status).to eq(200)
        end
        it "タスク削除．" do
            @headers["Authorization"] = "Token " + @user.token
            @task = FactoryBot.create(:task, user: @user)
            delete "/tasks/#{@task.id}", headers: @headers
            expect(response.status).to eq(200)
        end
    end

    context "トークン所持済みの他ユーザーによるPOSTリクエスト" do
        it "他ユーザーのタスク内容を更新しようとして失敗．" do
            # 他ユーザとしてログイン
            @another_user = FactoryBot.create(:user)
            @headers["Authorization"] = "Token " + @another_user.token
            # 本人ユーザのタスクをDB側に作成
            @task = FactoryBot.create(:task,user: @user)
            task_params = {
                "name":"update title",
                "content":"test content text","status":0,
                "deadline":"2020-04-23T00:15:46.020+09:00",
                "priority":2}
            # @userの所持タスク@taskを@another_userが更新
            put "/tasks/#{@task.id}", params: task_params.to_json, headers: @headers
            expect(response.status).to eq(403)
        end
        it "他ユーザーのタスクを削除しようとして失敗．" do
             # 他ユーザとしてログイン
             @another_user = FactoryBot.create(:user)
             @headers["Authorization"] = "Token " + @another_user.token
             # 本人ユーザのタスクをDB側に作成
             @task = FactoryBot.create(:task,user: @user)
             # @userの所持タスク@taskを@another_userが削除
             delete "/tasks/#{@task.id}", headers: @headers
             expect(response.status).to eq(403)
            #  タスクの生存を確認
        end
    end

    # トークン所持済みで他のユーザーのタスクへアクセスしようとする場合
end