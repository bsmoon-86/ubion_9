import pymysql

class Mydb:
    # 생성자 함수 (매개변수 : host, port, user, password, db)
    def __init__(self, 
                 _host = '127.0.0.1', 
                 _port = 3306, 
                 _user = 'root', 
                 _password = '1234', 
                 _db = 'ubion'):
        self.host = _host
        self.port = _port
        self.user = _user
        self.password = _password
        self.db = _db
     
    # Query문을 데이터베이스에 보내주고 결과값을 받아오는 함수 
    def sql_query(self, _sql, *_values):
        # 데이터베이스 서버와 연결
        _db = pymysql.connect(
            host = self.host,
            port = self.port, 
            user = self.user, 
            password = self.password, 
            db = self.db
        )
        # 커서 가상 공간을 생성
        cursor = _db.cursor(pymysql.cursors.DictCursor)
        # 입력값으로 받아온 sql query문을 실행
        cursor.execute(_sql, _values)
        # sql query문이 select 문이라면
        if _sql.lower().split()[0] == 'select':
            result = cursor.fetchall()
        else:
            _db.commit()
            result = 'Query OK'
        
        # 데이터베이스 서버와의 연결을 종료
        _db.close()
        
        return result


_db = pymysql.connect(
    host = '127.0.0.1', 
    port = 3306, 
    user = 'root', 
    password = '1234', 
    db = 'ubion'
)

cursor = _db.cursor(pymysql.cursors.DictCursor)

def sql_query2(sql, *values):
    cursor.execute(sql, values)
    if sql.lower().split()[0] == 'select':
        result = cursor.fetchall()
    else:
        _db.commit()
        result = 'Query OK'
    return result
