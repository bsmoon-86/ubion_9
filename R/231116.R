## 시각화 (그래프 표현)

library(ggplot2)
library(dplyr)

## 산점도 그래프 
mpg <- ggplot2::mpg

# 레이어를 하나씩 확인
# 배경 레이어 추가 + 그래프의 종류 
ggplot(
  data = mpg, 
  aes(x = displ, y=hwy)
  ) + geom_point() + xlim(3, 6) + ylim(20, 30)

# 막대 그래프 
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy)) -> group_data
# x, y축 데이터를 모두 입력하여 그래프를 생성
ggplot(
  data = group_data, 
  aes(x = drv, y = mean_hwy)
  ) + geom_col()
# x축의 데이터를 입력하여 x축 데이터의 빈도수를 그래프 표시
ggplot(data = mpg, aes(x = drv)) + geom_bar()

ggplot(
  data = group_data, 
  aes(x = reorder(drv, desc(mean_hwy)), y = mean_hwy)
) + geom_col()

# 라인 그래프 
View(mpg)

# 년도별 차량 출시 개수
mpg %>% 
  group_by(year) %>% 
  summarise(count = n()) -> group_data2

ggplot(
  data = group_data2, 
  aes(x = year, y=count)
  ) + geom_line()

economics <- ggplot2::economics
View(economics)

ggplot(
  data = economics, 
  aes(x = date, y = unemploy)
) + geom_line()

# 박스 플롯 그래프 
ggplot(
  data = mpg, 
  aes(x = drv, y = hwy)
) + geom_boxplot()

# sav 확장자 파일을 로드하기 위한 패키지 설치 
# install.packages('foreign')

library(foreign)

welfare <- read.spss(
  "csv/Koweps_hpc10_2015_beta1.sav", 
  to.data.frame = T)
View(welfare)

# 컬럼의 이름을 변경
rename(
  welfare, 
  gender = h10_g3, 
  birth = h10_g4, 
  marriage = h10_g10, 
  religion = h10_g11, 
  imcome = p1002_8aq1, 
  code_job = h10_eco9
) -> welfare

welfare[c(
  'gender', 
  'birth', 
  'marriage', 
  'religion', 
  'imcome', 
  'code_job')]

welfare %>% 
  select(gender, 
         birth, 
         marriage, 
         religion, 
         imcome, 
         code_job) -> welfare_copy

# 데이터프레임에서 결측치가 존재하는지 확인 
is.na(welfare_copy)
table(is.na(welfare_copy$gender))
table(is.na(welfare_copy$birth))
table(is.na(welfare_copy$marriage))
table(is.na(welfare_copy$religion))

## gender 컬럼의 데이터를 빈도수 체크 
## gender가 1이라면 male 변경
## gender가 2라면 female 변경
## gender가 9라면 - 변경
ifelse(
  welfare_copy$gender == 1, 
  'male', 
  ifelse(
    welfare_copy$gender == 2, 
    'female', 
    '-'
  )
)
table(welfare_copy$gender)


# 데이터프레임의 필터기능을 이용하여 데이터를 변경
# 조건식 : 성별이 1인 데이터의 gender 항목 데이터만 출력
welfare_copy[
  welfare_copy$gender == 1, 
  'gender'
] <- 'male'
table(welfare_copy$gender)
welfare_copy[
  welfare_copy$gender == 2, 
  'gender'
] <- 'female'
table(welfare_copy$gender)
rename(
  welfare_copy, 
  income = imcome
) -> welfare_copy
## imcome 데이터에서 0, 9999 데이터를 결측치로 변경(이상치로 판단)
welfare_copy$income == 0 | welfare_copy$income == 9999
welfare_copy$income %in% c(0, 9999) -> flag

welfare_copy[flag, ]

# case1
ifelse(
  flag, 
  NA, 
  welfare_copy$income
)

#case2
welfare_copy[
  flag, 
  'income'
] <- NA
welfare_copy[
  welfare_copy$income %in% c(0, 9999), ]

### 성별을 기준으로 하여 평균 임금 차이가 존재하는가?

### 성별을 기준으로 데이터를 필터링(2개 데이터)
### 임금의 평균 값(결측치를 제외)
male_data <- welfare_copy[
  welfare_copy$gender == 'male', ]
mean(male_data$income, na.rm=T)
female_data <- welfare_copy[
  welfare_copy$gender == 'female', 
]
mean(female_data$income, na.rm = T)
### income 데이터의 결측치를 제거 
### gender를 기준으로 그룹화
### 그룹을 연산을 이용하여 income의 평균 값 생성
### 해당하는 데이터를 그래프 시각화(막대 그래프)
welfare_copy %>% 
  filter(!is.na(income)) %>% 
  group_by(gender) %>% 
  summarise(mean_income = mean(income)) -> gender_income
ggplot(
  data = gender_income, 
  aes(x = gender, y=mean_income)
) + geom_col()








