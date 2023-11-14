# 외부의 패키지 파일을 설치 
install.packages('dplyr')
# 패키지를 로드 
library(dplyr)

df <- read.csv('csv/csv_exam.csv')
head(df)

# 파이프 연산자를 이용하여 함수를 실행 
# %>% : Ctrl(Command) + Shift + M 단축키를 이용

# filter(조건식) : 인덱스의 조건
df %>% filter(class == 1)

# Base
# 조건식 생성
df$class == 1
df[df$class == 1, ]

# select(조건식) : 컬럼의 조건
df %>% select('class', 'math')

#Base 
df[c('class', 'math')]

# 특정 컬럼을 제외하고 출력
df %>% select(-id)

# 인덱스의 조건과 컬럼의 조건을 모두 사용
df %>% filter(class == 1) %>% select(math, english)

# Base 
df[ df$class == 1 , c('math', 'english') ]

# 정렬을 변경(오름차순, 내림차순)
df %>% arrange(math)

df %>% arrange(desc(math))
df %>% arrange(-math)

# Base 
df[order(df$math),]

df[order(df$math, decreasing = TRUE), ]
df[order(-df$math), ]

# 정렬의 기준이 2개인 경우 
df  %>%  arrange(desc(class), math)

# 그룹화 연산
df %>% group_by(class) %>% 
  summarise(mean_math = mean(math), 
            mean_english= mean(english), 
            mean_science = mean(science))


