# flask라는 프레임워크 안에서 Flask 기능만 사용
from flask import Flask , render_template, request, redirect
import mod_sql as ms
# Flask class 생성 
# __name__ : 작업중인 파일의 이름
app = Flask(__name__)

# api들을 생성 

# @? -> 네비게이터 -> 연결 
# @app.route('/') -> 127.0.0.1:3000/ 요청이 들어왔을때 바로 아래의 함수를 호출
@app.route('/')
def index():
    # return "Hello World"
    # index.html을 유저에게 응답메시지로 되돌려준다.
    return render_template('index.html')

@app.route('/second')
def second():
    return render_template('second.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/signin')
def signin():
    # 유저가 보낸 데이터를 확인 
    print(request.args)
    id = request.args['input_id']
    password = request.args['input_pass']
    print(id)
    print(password)
    # 로그인 조건이 id가 'test' password가 '1111'인 
    # 경우에는 로그인이 성공 메시지 되돌려준다
    # 그 외의 경우에는 로그인이 실패 메시지 되돌려준다.
    # return request.args
    # if (id == 'test') & (password == '1111'):
    # if id == 'test' and password == '1111':
    #     return "로그인 성공"
    # else:
    #     return "로그인 실패"
    # DB server에서 유저의 정보를 확인하여 로그인 성공/실패 
    # mod_sql에 있는 Mydb class 생성
    mydb = ms.Mydb(
        '172.16.12.155', 
        3306, 
        'ubion', 
        '1234', 
        'ubion'
    )

    # sql 쿼리문을 작성 
    sql = """
        select 
        * 
        from 
        user 
        where 
        id = %s 
        and 
        password = %s
    """
    result = mydb.sql_query(sql, id, password)
    print("SELECT result -", result)
    print(len(result))
    if (result):
        return "로그인 성공"
    else:
        return redirect('/login')

app.run(host='0.0.0.0',port=3000, debug=True)
