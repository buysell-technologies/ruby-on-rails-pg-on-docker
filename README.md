# 機能要件
* ひとまずユーザーとタスクは1対多で作成(一つのタスクを複数ユーザーが共有する場合は考えない)
* 初期画面からのサインアップ(Userの作成)を実装
* ログイン機能と管理画面、そしてそこからTaskのCRUDを行えるようにする
* MyページではUserテーブルのCRUDを行えるようにする。
* 適宜バリデーションを入れること
* 優先順位はひとまず3段階。バリデーションして変な値が入らないように


# データベース構成
* Userテーブル
    * int: id
    * string: name
    * string: email
    * string(password_digest): password
* Taskテーブル
    * int: id
    * string: name
    * string: text(内容)
    * string: label
    * int: status(0:未着手, 1:着手,　2:完了)
    * datetime: deadline
    * int: priority
    * int: user_id