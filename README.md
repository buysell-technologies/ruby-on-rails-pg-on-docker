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

---

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

---

# Label
すべてログイン認証必須

## 特定タスクに付与されたラベルの一覧
```
curl -X GET -H "Authorization: Token Vk5ZdShmsPaGj1DBj7S3tuFX" -H "Content-Type: application/json" http://0.0.0.0/tasks/2/labels
```
```
{   "status":"SUCCESS",
    "message":"Label for this task",
    "data":[{
        "id":3,
        "name":"label c",
        "created_at":"2020-04-07T16:01:16.460+09:00",
        "updated_at":"2020-04-07T16:01:16.460+09:00"
        },
        {"id":1,
        "name":"label a",
        ...略
        }]
}
```

## 特定タスクにラベルを付与
```
curl -X POST -H "Authorization: Token Vk5ZdShmsPaGj1DBj7S3tuFX" -H "Content-Type: application/json" http://0.0.0.0/tasks/2/add_label -d '{"name":"Add Label"}'
```
```
{   "status":"SUCCESS",
    "data":[{
        "id":3,"name":"label c",
        "created_at":"2020-04-07T16:01:16.460+09:00",
        "updated_at":"2020-04-07T16:01:16.460+09:00"},
        {"id":1,"name":"label a",
        "created_at":"2020-04-07T16:01:16.447+09:00",
        "updated_at":"2020-04-07T16:01:16.447+09:00"},
        ...略
    ]}
```

## 特定タスクのラベルを削除
```
curl -X DELETE -H "Authorization: Token Vk5ZdShmsPaGj1DBj7S3tuFX" -H "Content-Type: application/json" http://0.0.0.0/tasks/2/delete_label/3'
```
```
{"status":"SUCCESS","message":"Deleted Label"}
```

---

以下はとりあえず作ったがもしかしたらいらないかも
## Show Label
```
curl -X GET -H "Authorization: Token Vk5ZdShmsPaGj1DBj7S3tuFX" -H "Content-Type: application/json" http://0.0.0.0/labels/1
```
```
{   "id":1,
    "name":"label a",
    "created_at":"2020-04-07T16:01:16.447+09:00",
    "updated_at":"2020-04-07T16:01:16.447+09:00"
}
```

## Create Label
```
    curl -X POST -H "Authorization: Token Vk5ZdShmsPaGj1DBj7S3tuFX" -H "Content-Type: application/json" http://0.0.0.0/labels -d '{"name":"label d"}'
```
```
{   "status":"create label",
    "data":{
        "id":4,
        "name":"label d",
        "created_at":"2020-04-08T10:51:29.341+09:00",
        "updated_at":"2020-04-08T10:51:29.341+09:00"}
} 
```

### Update Label
```
curl -X PUT -H "Authorization: Token Vk5ZdShmsPaGj1DBj7S3tuFX" -H "Content-Type: application/json" http://0.0.0.0/labels/4 -d '{"name":"change label d"}'
```
```
{   "status":"update label",
    "data":{
        "id":4,
        "name":"change label d",
        "created_at":"2020-04-08T10:51:29.341+09:00",
        "updated_at":"2020-04-08T11:30:07.853+09:00"}
}
``` 

### Delete Label
```
curl -X DELETE -H "Authorization: Token Vk5ZdShmsPaGj1DBj7S3tuFX" -H "Content-Type: application/json" http://0.0.0.0/labels/5
```
```
{   "status":"SUCCESS",
    "message":"Deleted Label",
    "data":{
        "id":5,
        "name":"label d",
        "created_at":"2020-04-08T12:37:31.821+09:00",
        "updated_at":"2020-04-08T12:37:31.821+09:00"}
}
```
