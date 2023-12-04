import pandas as pd
import numpy as np
from datetime import datetime

# 함수(buyandhold)를 생성 -> 매개변수는 4개
# (df(dataframe), col(columns명), start(문자형데이터), end(문자형데이터))
def buyandhold(df, col, start, end):
    # df에 결측치나 무한대 값들을 모두 제거 
    flag = df.isin([np.nan, np.inf, -np.inf]).any(axis=1)
    df = df.loc[~flag]
    if 'Date' in df.columns:
        # df에 있는 Date 컬럼을 시계열 데이터로 변경
        df['Date'] = pd.to_datetime(df['Date'], format='%Y-%m-%d')
        df.set_index('Date', inplace=True)
    else:
        df.index = pd.to_datetime(df.index)
    # col 매개변수를 이용하여 df에 해당하는 col 컬럼만 제외하고 모두 제거 
    df = df[[col]]
    # start, end 데이터를 시계열 데이터로 변경
    buy = datetime.strptime(start, '%Y%m').isoformat()
    sell = datetime.strptime(end, '%Y%m').isoformat()
    # daily_rtn 파생변수를 생성하여 일별 수익율을 계산해서 대입
    df['daily_rtn'] = df[col].pct_change()
    # start, end를 기준으로 df을 필터링
    df = df.loc[buy:sell]
    # rtn 파생변수를 생성하여 누적 수익율 계산하여 대입 
    df['rtn'] = (1+df['daily_rtn']).cumprod()
    # 누적 수익율의 마지막 데이터
    result = df['rtn'][-1]
    # 데이터프레임 리턴
    return df, result

    