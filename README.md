# 五倍的十八銅人

## 設計理念：

使用者的可以透過此作品設定任務，每個任務可以有多個標籤，點擊標籤就可以導向不同的搜尋結果，讓使用者能夠快速的找到不同類型的任務。
</br>


開發版本：

Ruby 2.6.0

Rails 5.2.3

</br>

Heroku:https://still-oasis-16053.herokuapp.com/

</br>

## ER-Model 欄位設定

### 1. User

</br>
PK: id:int </br>
email: String </br>
password: string </br>
role: int </br>

## 每個mission可以有0個以上的tag,且每個mission都只會有一個使用者

### 2. Mission 

</br>
PK: id:int </br>
FK: user_id:int </br>
name: string </br>
content: text </br>
priority: int </br>
status: int </br>
start_time: datetime </br>
end_time: datetime </br>
</br>

## tag_mission （多對多的資料表）

PK: id:int </br>
FK: mission_id:int </br>
FK: tag_id:int </br>
</br>

## 每個tag會有0個或多個mission

### 3. Tag

PK: id:int  </br> 
</br>
category:string 
</br>

![image](https://github.com/amoeric/5xruby/blob/master/ER-Model.png)
