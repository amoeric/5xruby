# 五倍的十八銅人

### 步驟4: 想像網站成品會是什麼樣子

目前想到的是建立三個model

### 1. User
PK: id:int </br>
account: string </br>
password: string </br>
role: string </br>

### 2. Mission
PK: id:int </br>
FK: user_id:int </br>
name: string </br>
content: text </br>
priority: string </br>
status: string </br>

### 3. Tag
PK: id:int </br>
FK: mission:id </br>
type: string </br>

![image](https://github.com/amoeric/5xruby/blob/master/%E8%9E%A2%E5%B9%95%E5%BF%AB%E7%85%A7%202019-07-08%20%E4%B8%8B%E5%8D%882.33.40.png)
