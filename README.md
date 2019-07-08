# 五倍的十八銅人

### 步驟4: 想像網站成品會是什麼樣子

目前想到的是建立三個model
</br>
## 每個使用者可以有0個以上的mission 
### 1. User  
PK: id:int </br>
account: string </br>
password: string </br>
role: int </br>

## 每個mission可以有0個以上的tag,且每個mission都只會有一個使用者
### 2. Mission 
PK: id:int </br>
FK: user_id:int </br>
name: string </br>
content: text </br>
priority: int </br>
status: int </br>
start_time: datetime </br>
end_time: datetime </br>
## 每個tag都只會有一個
### 3. Tag
PK: id:int  </br>
FK: mission_id:int  
</br>
category:string 
</br>

![image](https://github.com/amoeric/5xruby/blob/master/ER-Model%E4%BF%AE%E6%AD%A3%E7%89%88.png)
