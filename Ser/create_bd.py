import sqlite3
from venv import create

'''+++ Создать БД с авторизацией, где есть пароль и логин'''
'''Там же сделать интерфейс для наглядности'''

def soed():
    db = sqlite3.connect("pass.db")
    cursor = db.cursor()

db = sqlite3.connect("pass.db")
cursor = db.cursor()

#cursor.execute("DROP TABLE login")
with db:
    
    

    cursor.execute(
        '''
        CREATE TABLE IF NOT EXISTS login(
        id INTEGER PRIMARY KEY,
        login TEXT,
        password TEXT
        
        );
        
        '''
    )

    

db.commit()
db.close()
