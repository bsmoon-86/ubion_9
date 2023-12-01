from selenium import webdriver
from selenium.webdriver.common.by import By 
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup as bs
import pandas as pd
from datetime import datetime
import time

driver = webdriver.Chrome()
# 1초 딜레이 
time.sleep(0.5)
driver.get('https://www.naver.com')
# 1초 딜레이 
time.sleep(0.5)
# 검색어창 선택
element = driver.find_element(By.ID, 'query')
# 검색어창에 '야후파이낸스' 입력
element.send_keys('야후파이낸스')
# ENTER key 이벤트 발생
element.send_keys(Keys.ENTER)
# 1초 딜레이 
time.sleep(0.5)
# 야후파이낸스로 이동하는 하이퍼링크 태그를 선택
element2 = driver.find_element(
    By.CLASS_NAME, 'link_name'
)
# 하이퍼링크를 클릭 
element2.click()
# 1초 딜레이 
time.sleep(0.5)
# 새로운 탭이 생성이 되고 해당하는 2번째 탭으로 이동
driver.switch_to.window(
    driver.window_handles[1]
)
# 상단 메뉴에서 markets를 선택
element3 = driver.find_element(By.XPATH, 
                     '//*[@id="Nav-0-DesktopNav-0-DesktopNav"]/div/div[3]/div/nav/ul/li[3]/a')
# markets 클릭
element3.click()
# 1초 딜레이 
time.sleep(1)
# 상단 서브 메뉴에 있는 trending Ticker 선택
element4 = driver.find_element(By.XPATH, 
                                '//*[@id="SecondaryNav-0-SecondaryNav-Proxy"]/div/ul/li[3]/a')
# trending Ticker 클릭
element4.click()
# 1초 딜레이 
time.sleep(1)
# driver에 있는 html code를 로드 
html_data = driver.page_source

# BeautifulSoup을 이용하여 class 생성
soup = bs(html_data, 'html.parser')

# 해당 페이지에서 table tag만 추출
table_data = soup.find('table')

# column의 이름들이 있는 thead만 추출
thead_data = table_data.find('thead')
# thead에서 th 태그들을 모두 로드 
th_list = thead_data.find_all('th')
# th_list에 있는 th tag에서 텍스트만 추출하여 
# 리스트로 생성
columns = [i.get_text() for i in th_list]

# data들이 존재하는 tbody를 추출
tbody_data = table_data.find('tbody')
# tbody에서 tr 태그들을 모두 로드 
tr_list = tbody_data.find_all('tr')
# tr 태그 안에 있는 td태그에 있는 텍스트를 모두 추출하여
# 2차원 배열데이터를 생성
values = []
for tr_data in tr_list:
    td_datas = [i.get_text() for i in tr_data]
    values.append(td_datas)

# column의 값들과 values가 완성이 되었으므로 데이터프레임을 생성
df = pd.DataFrame(values, columns=columns)
# 현재의 날짜를 로드 
now = datetime.now()

# 데이터프레임을 csv로 저장
df.to_csv(f'yahoo{now.date()}.csv', index=False)

# 웹 드라이버를 종료
driver.close()