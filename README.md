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
    * status(0:未着手, 1:着手,　2:完了) : integer
    * deadline : time
    * priority : intger(0~4)
    * user_id : intger(外部制約)
* RelationTaskLabel(中間テーブル)
    * task_id
    * label_id
* Labelテーブル
    * id: integer
    * name: string
* Adminテーブル(最後に入れる事にした)

---

# API仕様
# User
## Sing Up(create user)
```
curl -X POST -H "Content-Type: application/json" http://0.0.0.0/signup -d '{"name":"hoge","email":"hoege@hoge.ac.jp","password":"password"}'
```
```
{   "status":"SUCCESS",
    "data":{
    "id":12,
    "name":"hoge",
    "email":"hoege@hoge.ac.jp",
    "password_digest":"$2a$12$2HmTjOtUNR7T8CuXIbPExeL8pu6DXdDrfClsN4pioE9UuijoXuHrq",
    "created_at":"2020-04-07T11:08:49.069+09:00",
    "updated_at":"2020-04-07T11:08:49.069+09:00",
    "token":"swAeDfHGyqGJao2tVwj4jrkG"}
}
```
## Log in
```
curl -X POST -H "Content-Type: application/json" http://0.0.0.0/login -d '{"name":"hoge","email":"hoege@hoge.ac.jp","password":"password"}'
```
トークンの取得
```
{"status":"SUCCESS","data":"swAeDfHGyqGJao2tVwj4jrkG"}
```
以降ログイン認証はHTTPヘッダーにトークンを含める必要がある

## Show user
ログインで得たトークンをリクエストヘッダに
```
curl -X GET -H "Authorization: Token n68TyqJdLtv21CiuDZz12euz" -H "Content-Type: application/json" http://0.0.0.0/users/1
```
```
{   "status":"SUCCESS",
    "message":"show user",
    "data":{
        "id":1,"name":"User 1",
        "email":"test1@test.ac.jp",
        "password_digest":"$2a$12$/jI0b5BhHOBUfGXNEgU5A.GklHkqcYyyt8taEIuPuij7BVwJvkao.",
        "created_at":"2020-04-07T02:12:41.319+09:00",
        "updated_at":"2020-04-07T02:12:41.319+09:00",
        "token":"E1B5Rt9oqceRaMvjt5NNw45m"
        }}
```

# Task
ログイン認証が必須
## Index task
```
curl -X GET -H "Authorization: Token swAeDfHGyqGJao2tVwj4jrkG" -H "Content-Type: application/json" http://0.0.0.0/tasks
```
```
{   "status":"SUCCESS",
    "message":"index tasks",
    "data":[
        {   "id":209,
            "name":"test title",
            "content":"test content text200",
            "status":0,
            "deadline":"2020-04-07T00:15:46.020+09:00",
            "priority":2,
            "created_at":"2020-04-07T11:43:02.649+09:00",
            "updated_at":"2020-04-07T11:43:02.649+09:00",
            "user_id":12
        },
        {   "id":208,
            "name":"test title",
            ...
        },
        ]
}
```

## Create task
```
curl -X POST -H "Authorization: Token swAeDfHGyqGJao2tVwj4jrkG" -H "Content-Type: application/json" -d '{"name":"test title","content":"test content text200","status":0,"deadline":"2020-04-07T00:15:46.020+09:00","priority":2}' http://0.0.0.0/tasks 
```
```
{   "status":"SUCCESS",
    "data":{
        "id":207,
        "name":"test title",
        "content":"test content text200",
        "status":0,
        "deadline":"2020-04-07T00:15:46.020+09:00",
        "priority":2,
        "created_at":"2020-04-07T11:35:26.692+09:00",
        "updated_at":"2020-04-07T11:35:26.692+09:00",
        "user_id":12
        }
}
```

## Show task
```
curl -X GET -H "Authorization: Token swAeDfHGyqGJao2tVwj4jrkG" -H "Content-Type: application/json"  http://0.0.0.0/tasks/207
```
```
{   "status":"SUCCESS",
    "message":"show tasks",
    "data":{
        "id":207,
        "name":"test title",
        "content":"test content text200",
        "status":0,
        "deadline":"2020-04-07T00:15:46.020+09:00",
        "priority":2,
        "created_at":"2020-04-07T11:35:26.692+09:00",
        "updated_at":"2020-04-07T11:55:20.780+09:00",
        "user_id":12
    }
}
```

## Update task
```
curl -X PUT -H "Authorization: Token swAeDfHGyqGJao2tVwj4jrkG" -H "Content-Type: application/json" -d '{"name":"change title","content":"test content text200","status":0,"deadline":"2020-04-07T00:15:46.020+09:00","priority":2}' http://0.0.0.0/tasks/207
```
```
{   "status":"SUCCESS",
    "data":{
        "id":207,
        "name":"change title",
        "content":"test content text200",
        "status":0,
        "deadline":"2020-04-07T00:15:46.020+09:00",
        "priority":2,
        "user_id":12,
        "created_at":"2020-04-07T11:35:26.692+09:00",
        "updated_at":"2020-04-07T11:55:20.780+09:00"
    }
}
```

## Delete task
```
curl -X DELETE -H "Authorization: Token swAeDfHGyqGJao2tVwj4jrkG" -H "Content-Type: application/json"  http://0.0.0.0/tasks/207
```
```
{   "status":"SUCCESS",
    "message":"Deleted task",
    "data":{
        "id":207,
        "name":"change title",
        ...
    }
}
```

# Label
すべてログイン認証必須
## Label index
```
curl -X GET -H "Authorization: Token n68TyqJdLtv21CiuDZz12euz" -H "Content-Type: application/json" http://0.0.0.0/tasks/1/labels
```
```
```