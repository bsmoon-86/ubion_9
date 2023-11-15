library(dplyr)
# 데이터프레임의 결합 

# 단순한 행 결합 -> 유니언 결합
df_1 <- data.frame(
  id = 1:5, 
  score = c(70, 80, 90, 60, 100)
)
df_2 <- data.frame(
  id = 4:8, 
  weight = c(80, 70, 60, 75, 55)
)
# 데이터프레임의 구조가 다르기 때문에 에러가 발생
rbind(df_1, df_2)
df_3 <- data.frame(
  id = 11:13, 
  score = c(100, 80, 70)
)
# 데이터프레임 구조가 같기 때문에 행이 추가
rbind(df_1, df_3)

bind_rows(df_1, df_2)
bind_rows(df_1, df_3)

bind_cols(df_1, df_2)


# 특정한 조건에 맞게 열을 결합 -> 조인 결합

# 유저의 이름과 유저의 소속을 나타내는 데이터프레임
df_4 <- data.frame(
  id = c('test', 'test2', 'test3', 'test4'), 
  company = c('A', 'A', 'B', 'D')
)
# 소속의 정보를 나타내는 데이터프레임
df_5 <- data.frame(
  company = c('A', 'B', 'C'), 
  loc = c('seoul', 'busan', 'ulsan')
)

# 교집합
# inner_join(데이터프레임명1, 데이터프레임명2, by='조건')
inner_join(df_4, df_5, by='company')

#왼쪽 데이터프레임을 기준으로 조인 결합
# left_join()
left_join(df_4, df_5, by='company')

# 오른쪽 데이터프레임을 기준으로 조인 결합
# right_join()
right_join(df_4, df_5, by='company')

# 합집합
# full_join()
full_join(df_4, df_5, by='company')


bind_rows(df_1, df_2, df_3)

df_6 <- data.frame(
  id = c('test', 'test2', 'test3', 'test4'), 
  pass = c('1234', '1111', '2222', '3333')
)

# 3개의 데이터프레임을 조인 결합
# df_4, df_6를 조인 결합
total_df <- inner_join(df_4, df_6, by='id')
# df_5 조인 결합
left_join(total_df, df_5, by='company')


library(ggplot2)


midwest <- ggplot2::midwest
View(midwest)

# 컬럼의 이름을 변경
# rename(기준의 데이터프레임, 새로운 컬럼의 이름 = 기준이 되는 컬럼의 이름)
# midwest에서 popasian컬럼의 이름을 asian 변경
# poptotal컬럼의 이름을 total 변경
rename(midwest, asian = popasian) -> midwest
View(midwest)
rename(midwest, total = poptotal) -> midwest

# 원본데이터는 보존을 한 상태에서 복사본을 만들어서 사용

# 특정 컬럼들만 선택
midwest %>% select(county, total, asian)
midwest[c('county', 'total', 'asian')] -> df

# 전체 인구수 대비 아시안 인구 비율
# ratio컬럼을 생성하여 아시안 인구 비율
# (아시아인 인구수 / 전체 인구수) * 100
(df$asian / df$total) * 100 -> ratio
cbind(df, ratio)
df$ratio <- ratio
df

df %>% mutate(ratio = (asian / total)*100) -> df

midwest %>% 
  select(county, total, asian) %>% 
  mutate(ratio = (asian / total)*100)
df
# 히스토그램 출력 
hist(df$ratio)

# ratio 전체 평균 값 출력 
# 백터 데이터의 평균 
mean(df$ratio) -> mean_ratio

# ratio 평균 값보다 해당하는 지역의 ratio 값이 높으면 large
# 이하면 small이라는 데이터를 group 컬럼에 데이터를 대입
df$ratio > mean_ratio

ifelse(df$ratio > mean_ratio, 'large', 'small')

# 벡터데이터에 데이터를 추가 
a <- c()
a[1] <- 3
a
a[2] <- 5
a
# ifelse() 함수와 같은 행동을 하는 함수 생성
iftest <- function(flag, t, f){
  # 벡터 데이터를 하나 생성(원소의 개수가 0)
  result <- c()
  # flag는 데이터의 타입 : 벡터
  # flag의 길이만큼 반복 실행하는 반복문을 생성
  # 초기값 지정
  i <- 1
  # flag 벡터데이터의 길이만큼 반복
  while (i <= length(flag)){
    # flag에 있는 i번째 데이터가 TRUE인 경우
    if(flag[i]){
      # 비어있는 벡터데이터의 i번째 항목에 t 변수의 데이터를 대입
      result[i] = t
    # flag에 있는 i번째 데이터가 FALSE인 경우
    }else{
      # 비어있는 벡터데이터의 i번째 항목에 f 변수의 데이터를 대입
      result[i] = f
    }
    # i 값을 1씩 증가
    i = i + 1
  }
  return (result)
}

df$group <- iftest(df$ratio > mean_ratio, 'large', 'small')

df

# group 컬럼의 데이터들의 데이터 개수를 체크 
table(df$group)

qplot(df$group)

## midwest 데이터 정제
## popadults 컬럼 : 해당 지역의 성인 인구수
## poptotal 컬럼 : 해당 지역의 전체 인구수
## "전체 인구수 대비 미성년자의 인구 비율" 생성
midwest <- ggplot2::midwest

## popadults컬럼의 이름을 adult로 변경
## poptotal컬럼의 이름을 total로 변경
## county, adult, total 컬럼을 제외한 데이터를 제거 
## child 컬럼을 생성하여 total - adult 데이터 대입
## '전체 인구수 대비 미성년자의 인구 비율'이라는 데이터를 
## 생성하여 child_ratio 컬럼에 대입 
## 전체 인구수 대비 미성년자의 인구 비율이 
## 가장 높은 상위 5개의 지역 출력

rename(midwest, adult = popadults) -> midwest
midwest <- rename(midwest, total=poptotal)

midwest2 <- midwest


## base
# 3개의 컬럼을 제외한 나머지 제거 
midwest[c('county', 'adult', 'total')] -> midwest
# 새로운 child 컬럼 생성
midwest$total - midwest$adult -> midwest$child
(midwest$child / midwest$total) * 100 -> midwest$child_ratio
# child_ratio를 기준으로 내림차순 정렬
order(midwest$child_ratio, decreasing = TRUE) -> flag
order(-midwest$child_ratio)
# 행의 조건식에 order() 데이터를 대입
midwest[flag, ] -> midwest
# 상위 5개의 지역을 확인
head(midwest, 5)

### dplyr 패키지 이용
midwest2 %>% 
  select(county, adult, total) %>% 
  mutate(child = total - adult,
         child_ratio = (child / total) * 100) %>% 
  arrange(desc(child_ratio)) %>% 
  mutate(grade = ifelse(
    child_ratio >= 40, 
    'high', 
    ifelse(
      child_ratio >= 30, 
      'middle', 
      'low'
    )
  )) %>% 
  group_by(grade) %>% 
  summarise(count = n())

## 미성년 비율이 40% 이상이면 high
## 미성년 비율이 30%이상 40% 미만이면 middle
## 미성년 비율이 30% 미만이면 low
## 로 만들어진 데이터를 grade 컬럼에 대입
# grade 데이터의 빈도수를 출력하고 막대그래프로 표시 
ifelse(
  midwest$child_ratio >= 40, 
  'high', 
  ifelse(
    midwest$child_ratio >= 30, 
    'middle', 
    'low'
  ))

midwest$child_ratio >= 40 -> flag
midwest$child_ratio >= 30 -> flag2
flag2
# 반복문인 for문의 기본형 : for (변수명 in 벡터데이터)
new_result <- c()
flag_index <- 1
for (i in flag){
  if(i){
    new_result[flag_index] <- 'high'
  }else{
    if(flag2[flag_index]){
      new_result[flag_index] <- 'middle'
    }else{
      new_result[flag_index] <- 'low'
    }
  }  
  flag_index = flag_index + 1
}
flag[30:40]
flag2[30:40]
new_result -> midwest$grade

# 빈도수 확인 
table(midwest$grade)
qplot(midwest$grade)
