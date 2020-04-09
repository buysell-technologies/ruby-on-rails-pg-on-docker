require 'rails_helper'

describe 'Userへのリクエスト.', type: :request do
    before do
        @headers = {"Content-Type" => 'application/json'}
    end

    context "パラメータが正常な場合．" do
        before do
            @user_params = {name: 'test user',email: 'sample@test.ac.jp',password: 'password'}
        end

        it 'サインアップに成功するとステータスコード200を返す．' do
            post "/signup" , params: @user_params.to_json, headers: @headers
            expect(response.status).to eq(200)
        end
        it 'ログインに成功するとステータスコード200を返す．' do
            user = FactoryBot.create(:user)
            puts user
            post "/login" , params: {email: user.email, password: user.password}.to_json, headers: @headers
            expect(response.status).to eq(200)
        end
        it 'ログイン後にユーザー情報を取得しステータスコード200を返す．' do
            user = FactoryBot.create(:user)
            # トークンをヘッダに込める
            @headers["Authorization"] = "Token " + user.token
            get "/users/#{user.id}", headers: @headers
            expect(response.status).to eq(200)
        end
        it '登録済みユーザとログインに成功後，レスポンスにTokenを受け取る．' do
            # ユーザの作成とデータのDBへの保存
            user = FactoryBot.create(:user)
            # 登録済みユーザとしてログイン
            post "/login" , params: {email: user.email, password: user.password}.to_json, headers: @headers
            # レスポンスで取得したトークンとDB側の整合性を確認
            expect(JSON.parse(response.body)["data"]).to eq(user.token)
        end
    end


    context "メールアドレスが不正でバリデーションエラーの場合．" do
        before do
            # メールアドレスの形式が不正
            @user_params = {name: 'test user',email: 'xxxxxxxxxxxxxxxxxxxx',password: 'password'}
        end
        it 'サインアップに失敗．ステータスコード400を返す．' do
            post "/signup" , params: @user_params.to_json, headers: @headers
            expect(response.status).to eq(400)
        end
        it 'サインアップに失敗．エラーメッセージを確認' do
            post "/signup" , params: @user_params.to_json, headers: @headers
            expect(JSON.parse(response.body)["data"]).to eq("email"=>["is invalid"])
        end
        it '存在しないユーザのためログインに失敗．ステータスコード400を返す' do
            post "/login" , params: {email: @user_params[:email], password: @user_params[:password]}.to_json, headers: @headers
            expect(response.status).to eq(400)
        end
    end
end