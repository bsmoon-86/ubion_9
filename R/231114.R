# 함수 생성 (매개변수에 기본값이 존재하는 경우)
func_1 <- function(x, y=3){
  result = x ^ y
  return (result)
}
print(func_1(10, 2))
print(func_1(10))
func_2 <- function(x){
  y <- 3
  result <- x ^ y
  return (result)
}
print(func_2(10))

# 인자의 개수가 가변인 경우
func_3 <- function(x, ...){
  print(x)
  print(c(...))
}
func_3(1, 5, 3, 1)
func_3(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

func_4 <- function(x, y){
  return (x ^ y)
}
print(func_4(10, 2))
print(func_4(y = 10, x =2))

func_5 <- function(x, y=1, z=2, a=3, b=4, c=5){
  result = c(x, y, z, a, b, c)
  return (result)
}
#  func_5를 호출할때 매개변수 a의 데이터만 변경
print(func_5(5, 1, 2, 10))
print(func_5(5, a = 10))

# 반복문을 이용해서 합계 -> 함수에서 해당하는 코드를 대입하여 실행
func_6 <- function(start, end){
  # 합계라는 변수를 생성하여 0을 대입
  result <- 0
  func_list <- start:end
  for (i in func_list){
    # 반복 실행할때마다 i의 값을 result에 누적 합
    result = result + i
  }
  return(result)
}
print(func_6(1, 10))
print(func_6(1, 100))

func_7 <- function(start, end){
  # 합계 변수 생성
  result <- 0
  # 시작 값
  i <- start
  while (i <= end){
    result = result + i
    i = i + 1
  }
  return(result)
}
print(func_7(1, 10))
print(func_7(1, 100))

# 증가값을 추가하여 함수 생성 
func_8 <- function(start, end, add){
  result <- 0
  
  i <- start
  
  while( i <= end ){
    result = result + i
    i = i + add
  }
  return (result)
}
print(func_8(0, 100, 2))

# 벡터데이터 생성 
print(c(1,2,3,4,5))
print(1:5)
print(seq(1, 10, by=3))

func_9 <- function(start, end, add = 1){
  result <- 0
  
  func_list <- seq(start, end, by=add)
  
  for (i in func_list){
    result = result + i
  }
  return (result)
}
print(func_9(0, 100, 2))
print(func_9(0, 100))

func_10 <- function(start, end, add){
  result <- 0 
  # start와 end 중 start 만약에 더 크다면?
  # end 매개변수가 시작값 start 매개변수가 종료값
  if (start > end){
    i <- end
    while( i <= start ){
      result <- result + i
      i <- i + add
    }
  }else{
    i <- start
    while(i <= end){
      result = result + i
      i = i + add
    }
  }

  return (result)
}
print(func_10(100, 0, 1))
print(func_10(0, 100, 1))

# func_10() 함수를 라인 줄이기 
func_11 <- function(start, end, add){
  result <- 0
  if(start > end){
    # 반복문의 시작값과 종료 값을 변수에 저장
    i <- end
    j <- start
  }else{
    i <- start
    j <- end
  }
  while(i <= j){
    result <- result + i
    i <- i + add
  }
  return(result)
}
print(func_11(0, 100, 1))
print(func_11(100, 0, 1))

# 커스텀 연산자 
"%a%" <- function(x,y){
  result <- (x+y)^y
  return (result)
}
5%a%2
4%a%2

# 데이터프레임을 생성 
name <- c('test', 'test2', 'test3', 'test4')
grade <- c(1, 1, 3, 2)

# 벡터 데이터를 이용하여 데이터프레임 생성
student <- data.frame(name, grade)
print(student)
student

# 새로운 벡터 데이터를 생성(데이터의 길이가 3)
score <- c(80, 90, 70)
# 길이가 다른 벡터 데이터를 데이터프레임을 결합(에러가 발생)
print(data.frame(name, score))

# 행렬 생성 
midturm <- c(70, 80, 60, 90)
final <- c(60, 100, 80, 80)
# cbind() 함수를 이용하여 벡터데이터를 결합
score <- cbind(midturm, final)
print(score)

# 벡터 데이터들의 합
total_score = midturm + final
print(total_score)
# 벡터 데이터와 숫자형태의 데이터의 합
print(midturm + 5)
print(5 + midturm)

# 데이터프레임과 행렬과 벡터데이터를 결합하여 새로운 데이터프레임 생성

students <- data.frame(student, score , total_score)
print(students)

# 데이터프레임에 단일 데이터를 추가하는 경우 모든 인덱스에 
# 해당하는 단일 데이터가 대입
print(data.frame(student, score, total_score,  x = 'A'))

# 데이터프레임에 새로운 컬럼을 추가 
# cbind()
# 벡터데이터를 새로운 컬럼에 추가 
gender = c('F', 'M', 'M', 'F')
cbind(students, gender) -> students

# R 기본적인 필터링

# 특정 컬럼의 데이터를 추출
# 데이터프레임$컬럼명
# 데이터프레임[[컬럼명]]
# 데이터프레임[[컬럼의 위치]]
students$midturm
students[['midturm']]
students[[3]]

# []를 이용한 필터링
# 데이터프레임[행의 조건식, 열의 조건식]
students[1,]
students[1:3, ]
students[c(2, 4),]

# students에서 중간 점수가 70점 이상이고, 
# 기말 점수가 80점 이상인 학생의 정보를 출력
students$midturm >= 70 & students$final >= 80 -> flag
students[flag,]

# 성별이 'M'인 학생의 중간 성적과 기말 성적 출력
students[ students$gender == 'M', c('midturm', 'final')]

# 새로운 데이터를 데이터프레임에 결합 (인덱스 추가 )
# rbind()
# 유의 사항 : 데이터의 구조가 같은 형태에 데이터프레임을 결합
new_student <- data.frame(
  name = 'test5', 
  grade = 2, 
  gender = 'F', 
  midturm = 90, 
  final = 80, 
  total_score = 170
)
students
new_student

rbind(students, new_student)

new_student2 <- data.frame(
  name = 'test6', 
  grade = 3, 
  gender = 'M'
)

rbind(students, new_student2)

# 데이터프레임의 데이터의 순서를 변경 (오름차순, 내림차순)
# order()
students
order(students$grade) -> order_flag
students[order_flag, ]

# 내림차순 정렬
order(students$final, decreasing = TRUE) -> order_flag2
students[order_flag2, ]

order(-students$midturm) -> order_flag3
students[order_flag3, ]

# 통계 요약 정보 출력
summary(students)

# 경로 
# 절대 경로
  # 절대적인 주소를 의미한다. 
  # 환경이 변하더라도 같은 위치를 지정
  # ex) window( c:/user/admin/document/a.txt ) mac( /opt/bin/a.txt )
  # ex) https://www.google.com, https://www.naver.com
# 상대 경로
  # 상대적인 주소를 의미한다.
  # 환경이 변하면 환경에따라 경로도 변경
  # 현재 작업중인 위치에서 상위 폴더나 하위 폴더로 이동
  # ../ : 현재 작업중인 디렉토리에서 상위 디렉토리로 이동
  # ./ : 현재 디렉토리 
  # 디렉토리명/ : 하위 디렉토리로 이동

# 외부의 데이터 파일인 csv_exam.csv 파일을 로드하여 사용
# csv 하위 디렉토리 이동 -> csv_exam.csv
# 외부의 csv 파일을 로드하기 위한 함수
# read.csv(파일의 경로)
# 상대 경로
read.csv("csv/csv_exam.csv") -> df
# 절대 경로
read.csv("C:\\Users\\moons\\Documents\\GitHub\\ubion_9\\R\\csv\\csv_exam.csv")

# 데이터프레임의 상위 6개를 출력 
head(df)
head(df, 3)

tail(df)
tail(df, 3)

# 데이터프레임의 크기를 출력하는 함수 
dim(df)

# 데이터프레임의 구조(정보)를 출력하는 함수 
str(df)


# 데이터프레임을 엑셀에서 표의 형태처럼 뷰어를 이용하여 확인하는 함수
View(df)

# df 데이터프레임에서 각각 성적들을 합한 벡터데이터를 구하고 
# 벡터데이터를 새로운 컬럼 total에 대입하여 데이터프레임 생성

# 각 컬럼의 데이터를 백터 데이터로 추출 -> 벡터데이터 끼리의 합
# -> 기존의 데이터프레임에 해당하는 벡터 데이터를 결합
df$math
df[['math']]
df[[3]]
df$math + df$english + df$science -> total

# cbind()함수를 이용하여 컬럼을 추가 
cbind(df, total)

# 특정 컬럼을 지정하여 해당하는 부분에 데이터를 대입
df$total <- total
df

# 평균 성적이라는 컬럼을 생성하여 
# 합계 점수에서 과목수 만큼 나눈 데이터를 대입
df$total / 3 -> mean_score

cbind(df, mean_score)

df$mean <- mean_score
df

# 조건문을 이용하여 컬럼의 데이터를 생성
# 조건문 함수 : 
# ifelse(조건식, 조건식이 참인 경우의 값, 조건식이 거짓인 경우의 값)
# 평균 점수가 65점 이상이면 'pass' 65점 미만이라면 'fail'
ifelse(df$mean >= 65, 'pass', 'fail')

# 평균 점수가 65점 초과이면 'pass' 65점 미만이면 'fail' 65점이면 'hold'
ifelse(
  df$mean > 65, 
  'pass', 
  ifelse(
    df$mean == 65, 
    'hold', 
    'fail'
  )
) -> df$result
df


