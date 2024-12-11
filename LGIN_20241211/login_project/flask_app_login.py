#!/usr/bin/env python3

from flask import Flask, request, render_template
import sqlite3
import datetime

login_app = Flask(__name__)

db_name = 'user.db'

#### RE-INITIALIZING DATABASE => deleting all records from test database
@login_app.route('/delete/all', methods=['POST', 'DELETE'])
def delete_all():
    db_conn = sqlite3.connect(db_name)
    c = db_conn.cursor()
    sql_statement = "DELETE FROM USER_PLAIN ;"
    c.execute(sql_statement)
    sql_statement = "DELETE FROM USER_HASH ;"
    c.execute(sql_statement)
    db_conn.commit()
    db_conn.close()
    return "Test records deleted\n"

@login_app.route('/')
def account():
    return render_template("index.html")

@login_app.route('/login')
def login():
    return render_template("login.html")

@login_app.route('/map')
def map_page():
    return render_template("map.html")

@login_app.route('/time')
def time_page():
    return render_template("time.html", datetime_now = datetime.datetime.now())

#### MAIN
if __name__ == "__main__":
    login_app.run(host="0.0.0.0", port=5555, debug=True)
