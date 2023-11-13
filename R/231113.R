# 주석
# 다른 사람들에게 코드를 부가적으로 설명 부분

# 변수를 설정 
a <- 10
b = 3
5 -> c

print(a)
print(b)
print(c)

# 백터 데이터 생성 
# c() 함수를 이용하여 생성
d = c(1, 2, 3, 4, 5)
print(d)

# 시작값 : 종료값
e = 1:5
print(e)

# 행렬 생성 
# array() dim를 이용하여 행렬 생성
f = array(1:20, dim=c(4, 5))
print(f)
g = array(1:20, dim=c(4, 4))
print(g)
h = array(1:20, dim=c(4, 6))
print(h)

# 행렬 생성 
# matrix()
a = matrix(1:20, nrow=2)
print(a)

# 리스트 데이터 생성
b = list(name='test', age=20, phone='01012345678')
print(b)

c = c('test',20,'01012345678')
print(c)
print(c[1])
print(b['name'])


# 데이터프레임 생성
df = data.frame(
  name = c('test', 'test2', 'test3'), 
  age = c(20, 30, 40), 
  phone = c('01012345678', '01011112222', '01099997777')
)
print(df)
# 백터의 개수가 다르므로 에러가 발생
df2 = data.frame(
  name = c('test', 'test2', 'test3'), 
  age = c(20, 30, 40), 
  phone = c('01012345678', '01011112222')
)


# 연산자

# 산술연산자 
x <- 10
y <- 3
print(x + y)
print(x - y)
print(x * y)
print(x / y)
print(x ^ y)
print(x %% y)
print(x %/% y)

# 비교연산자
print(x == y)
print(x != y)
print(x > y)
print(x < y)

# 논리연산자 
print(!TRUE)
z <- 5
print((x > y) & (z > x))
print((x > y) | (z > x))

# 조건문 
# 특정한 조건식이 참인 경우 실행 할 코드와 
# 거짓인 경우 실행 할 코드를 나눠서 작성
if (y > 2){
  print('y는 2보다 크다')
}

if(y > 4){
  print('y는 4보다 크다')
}

# 참인 경우와 거짓인 경우 다른 코드를 실행 하는 방법
#if ~ else문
if(y > 4){
  print('y는 4보다 크다')
}else{
  print('y는 4보다 작거나 같다')
}

# 조건식이 여러개인 경우
score = 55
# score가 90점 이상이면 A 
# 90미만 그리고 80 이상이면 B 
# 80미만 70이상이면 C 70미만 60이상이면 D
# 그외에는 F
if(score >= 90){
  print('A')
}else if(score >= 80){
  print('B')
}else if(score >= 70){
  print('C')
}else if(score >= 60){
  print('D')
}else{
  print('F')
}

# 로그인 조건식 사용하는 부분
id = 'test2'
password = '1111'

if(id == 'test2' & password == '1111'){
  print('성공')
}else{
  print('실패')
}


# which문 
# 백터데이터에서 조건식이 일치하는 위치의 값을 출력
name <- c('test', 'test2', 'test3')

which(name == 'test2')
which(name != 'test2')
which(name == 'test5')


# 반복문 

# for문 
# 백터데이터의 원소의 개수만큼 반복 실행
array_a = 1:10

for(i in array_a){
  print(i)
}

# 비순서형 백터데이터를 이용하여 for문 생성
array_b = c(6, 2, 8, 1)

for (i in array_b){
  print(i)
}

array_c = c('test', 'test5', 'test2', 'test10')
for (i in array_c){
  print(i)
}


# while문 
# 초기 시작값을 지정하고 해당하는 값을 반복할때마다 증감 시켜서 
# 조건식이 거짓이 될 때까지 반복 실행

# 초기 시작값을 지정
i = 1

while (i <= 10) {
  print(i)
  i = i + 1
}

j = 1
while (j <= 10) {
  j = j + 1
  print(j)
}

# 반복문을 이용하여 1부터 10까지 합계
# 합계라는 변수의 초기값은 0으로 지정
result = 0

# 1부터 10까지 반복을 하는 반복문을 생성
a = 1:10
for (i in a){
  result = result + i
  # 첫번째 반복 : i = 1, result = 0 + 1 -> result = 1
  # 두번째 반복 : i = 2, result = 1 + 2 -> result = 3
  # 세번째 반복 : i = 3, result = 3 + 3 -> result = 6
  # 네번째 반복 : i = 4, result = 6 + 4 -> result = 10
}
print(result)

# 무한 반복의 경우
while (TRUE){
  print('a')
}


# while문으로 1부터 10까지의 합계

# 합계라는 초기값 0 생성
result = 0
# 반복문에서 사용할 초기 값을 지정
i = 1
while (i < 11){
  # result에 i의값을 누적 합
  result = result + i
  i = i + 1
}
print(result)


# break 
# 반복문을 강제로 종료
a = 1:10
for (i in a){
  print(i)
  if (i == 5){
    break
  }
}

i = 1 
while(i <= 10000000000){
  print(i)
  if(i == 5){
    break
  }
  i = i + 1
}

# next
# 반복문으로 되돌아간다.(반복횟수는 증가)
a = 1:10
for (i in a){
  if (i <= 3){
    next
  }
  print(i)
}

for (i in a){
  print(i)
  if (i <= 3){
    next
  }
}

i = 1
while (i <= 10){
  if (i <= 3){
    i = i + 1
    next
  }
  print(i)
  i = i + 1
}

# 다중 for문 
a <- 2:9
b <- 1:9
for (i in a){
  for (j in b){
    print(i*j)
  }
}

# 1. 1부터 100까지의 숫자중에 짝수의 합계는 몇인가?

# 합계라는 변수를 생성 0이라는 데이터는 대입
sum = 0
# 반복문 생성 (for, while) 1부터 100까지 반복을 하는 반복문 생성

# 백터 데이터 생성
list_a = 1:100
for (i in list_a){
  # 값들을 한번씩 출력
  # print(i)
  # 해당하는 값들을 합계에 누적 합(1부터 100까지의 합계 확인)
  # sum = sum + i
  # 짝수라는 조건식을 생성
  if (i %% 2 == 0){
    # 반복문에서 짝수라는 조건식을 이용하여 해당하는 조건식이 참인 경우 합계에 누적합
    sum = sum + i
  }
}
print(sum)

# 1부터 100까지 숫자 중 짝수인 데이터의 누적 합
# 2부터 100까지 2씩 증가시킨 데이터의 누적합
sum = 0
i = 2

while (i <= 100){
  sum = sum + i 
  i = i + 2
}
print(sum)


# 2. 1부터 100까지의 누적합을 하는 중 합계가 900이 넘어가는 최초의 시점은 언제인가?

# 1부터 100까지의 합계를 구하는 반복문 생성
# 합계가 900 이상이 될때 조건식 생성
# 반복문을 강제로 종료
# i의 값과 합계의 값을 출력
 
sum = 0
list_a = 1:100

for(i in list_a){
  sum = sum + i
  if (sum >= 900){
    break
  }
} 
print(i)
print(sum)

sum = 0
i = 1
while (i <= 100){
  # 1
  sum = sum + i
  # 2
  if(sum >= 900){
    break
  }
  i = i + 1
  # 3
}
print(i)
print(sum)
cat(i, sum)

# 3. 두개의 주사위를 굴려서 두 주사위의 합이 9인 경우들을 모두 출력하시오
# 다중 for문

list_a = 1:6
# 첫번째 for문에서 첫번째 주사위의 경우의 수 만큼 반복
for (i in list_a){
  # 두번째 for문에서 두번째 주사위의 경우의 수 만큼 반복
  for (j in list_a){
    # 두개의 반복문에서 사용하는 변수 i, j 의 합이 9인 조건식을 생성
    # print(i + j)
    if( i + j == 9 ){
      # 조건식이 참인 경우 i, j의 데이터를 출력
      # print(i)
      # print(j)
      cat(i, j, '\t')
      # print('')
    }
  }
}

# 함수 생성 

# 매개변수가 존재하지 않는 함수 생성
func_1 = function(){
  print('Hello R')
}
func_1()
func_1()

# 매개변수가 존재하는 함수를 생성
func_2 <- function(x, y){
  result = x + y
  print("result")
  return(result)
}
print(func_2(5, 3))
print(func_2(1, 2))
result2 = 1
print(result)
func_result = func_2(10, 2)

# 매개변수의 개수와 인자의 개수를 다르게 호출한다면?
print(func_2(3))
print(func_2(3, 2, 1))

