import pymysql

_db = pymysql.connect(
    host = '127.0.0.1', 
    port = 3306, 
    user = 'root', 
    password = '1234', 
    db = 'ubion'
)

cursor = _db.cursor(pymysql.cursors.DictCursor)

def sql_query(sql, *values):
    cursor.execute(sql, values)
    if sql.lower().split()[0] == 'select':
        result = cursor.fetchall()
    else:
        _db.commit()
        result = 'Query OK'
    return result
