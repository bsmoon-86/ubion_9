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

## tibble 데이터의 형태를 data.frame 형태로 변경 
as.data.frame(welfare_copy) -> welfare_copy


## 나이에 따른 임금의 차이가 어느정도인가?

## 나이 라는 데이터는 존재하지 않는다. 
## age 컬럼을 생성하여 현재년도(2015) - birth의 값을 대입
## income 데이터에서 결측치를 제외
## age를 기준으로 그룹화
## 그룹화 연산을 하여 income의 평균 값을 출력
## 해당 결과를 막대그래프로 출력
welfare_copy %>% 
  mutate(age = 2015 - birth) %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income)) -> age_income
ggplot(
  data = age_income, 
  aes(x = age, y = mean_income)
) + geom_col()
str(welfare_copy)
2015 - welfare_copy$birth -> age
cbind(welfare_copy, age) -> welfare_copy
welfare_copy$age <- age

## 연령대별 임금의 차이를 확인해보자
## 연령대 데이터는 존재 하지 않는다. 
## 연령대(ageg) 컬럼을 생성하여 
## age가 40 미만이라면 'young'
## 40이상 60 미만이라면 'middle'
## 60이상이라면 'old'
## 데이터를 대입
## income 데이터 중 결측치를 제외하고 
## 연령대별로 그룹화
## 평균 임금 출력 & 막대 그래프 시각화
welfare_copy %>% 
  mutate(ageg = ifelse(
    age < 40, 'young', 
    ifelse(age < 60, 'middle', 'old')
  )
  ) %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income)) -> ageg_income
ageg_income[c(3, 1, 2),]
ggplot(
  data = ageg_income, 
  aes(x = ageg, y = mean_income)
) + geom_col()

## 그래프의 순서를 young, middle, old 순으로 바꿔서 출력

ggplot(
  data = ageg_income, 
  aes(x = ageg, y = mean_income)
) + geom_col() + scale_x_discrete(
  limits = c('young', 'middle', 'old')
)

welfare_copy %>% 
  mutate(ageg = ifelse(
    age < 40, 'young', 
    ifelse(age < 60, 'middle', 'old')
  )
  ) -> welfare_copy


## 연령대와 성별을 기준으로 임금의 평균을 출력하고 그래프 시각화

welfare_copy %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, gender) %>% 
  summarise(mean_income = mean(income)) -> ageg_gender_income

ggplot(
  data = ageg_gender_income, 
  aes(x = ageg, y = mean_income, fill=gender)
) + geom_col(position = 'dodge') + scale_x_discrete(
  limits = c('young', 'middle', 'old')
)

## excel 데이터를 로드하기 위한 패키지 설치 
install.packages('readxl')
library(readxl)

read_excel("csv/Koweps_Codebook.xlsx", sheet = 2) -> code_book

## 직업 별 평균 임금 어떠한가?

## welfare_copy와 code_book를 조인 결합(left join) -> job_data

## 결합된 데이터를 이용하여 
## income이 결측치인 데이터를 제거 
## 직업명(job)을 기준으로 그룹화 
## 그룹화 연산 income의 평균 값 출력

## 그룹 데이터를 이용하여 막대 그래프 시각화 
## (평균 임금이 높은 순으로 표시)

left_join(welfare_copy, code_book, by='code_job') -> job_data

job_data %>% 
  filter(!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income)) -> job_income

job_income %>% 
  arrange(-mean_income) %>% 
  head(10) -> top10

ggplot(
  data = top10, 
  aes(x = reorder(job, mean_income), y = mean_income)
) + geom_col() + coord_flip()

