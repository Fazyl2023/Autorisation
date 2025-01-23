from email import message
import sqlite3
import create_bd
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

# Модель данных для регистрации
class User(BaseModel):
    login: str
    password: str

# Функция для подключения к базе данных
def get_db_connection():
    return sqlite3.connect("pass.db")

# Регистрация пользователя
@app.post("/register/")
async def register_user(user: User):
    if len(user.login) < 5 or len(user.password) < 5:
        raise HTTPException(status_code=400, detail="Логин и пароль должны быть длиной не менее 5 символов.")

    db = get_db_connection()
    cursor = db.cursor()

    # Проверка существующего пользователя
    cursor.execute("SELECT * FROM login WHERE login = ?", (user.login,))
    existing_user = cursor.fetchone()

    if existing_user:
        raise HTTPException(status_code=400, detail="Пользователь с таким логином уже существует.")

    # Добавление нового пользователя
    with db:
        cursor.execute("INSERT INTO login (login, password) VALUES (?, ?)", (user.login, user.password))
    
    db.close()
    return {"message": "Пользователь успешно зарегистрирован"}

# Получение списка всех пользователей
@app.get("/users/")
async def get_users():
    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute("SELECT login FROM login")
    users = cursor.fetchall()

    db.close()
    return {"users": [user[0] for user in users]}



@app.post("/auth/")
async def auth_user(user: User):
    db = get_db_connection()
    cursor = db.cursor()

    # Проверка существующего пользователя
    cursor.execute("SELECT * FROM login WHERE login = ?", (user.login,))
    existing_log = cursor.fetchone()
    cursor.execute("SELECT * FROM login WHERE password = ?", (user.password,))
    existing_pass = cursor.fetchone()
    if existing_log and existing_pass:
        return {" message: Успешный вход!" }
    else:
        return {"message: Неправильное имя пользователя или пароль"}
    
