# 機能要件
* ひとまずユーザーとタスクは1対多で作成(一つのタスクを複数ユーザーが共有する場合は考えない)
* 初期画面からのサインアップ(Userの作成)を実装
* ログイン機能と管理画面、そしてそこからTaskのCRUDを行えるようにする
* MyページではUserテーブルのCRUDを行えるようにする。
* 適宜バリデーションを入れること
* 優先順位はひとまず5段階(仮)


# データベース構成
* Userテーブル
    * id: integer
    * name: string
    * email: string
    * password: string(password_digest)
* Taskテーブル
    * id: integer
    * name: string
    * content: text
    * label: string
    * status(0:未着手, 1:着手,　2:完了) : integer
    * deadline : time
    * priority : intger
    * user_id : intger(外部制約.ユーザーテープル追加時にカラムを後から追加)