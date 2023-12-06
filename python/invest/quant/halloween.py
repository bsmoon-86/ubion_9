import pandas as pd
from datetime import datetime
from dateutil.relativedelta import relativedelta


# 함수를 생성 
# 매개변수의 개수는? 데이터프레임, 시작년도, 종료년도, 시작월
def six_month(_df, _start, _end, _month):
    # 인덱스가 Date인지 확인하는방법?
    if 'Date' in _df.columns:
        # Date가 컬럼에 존재하는경우 
        # Date 컬럼을 시계열 데이터로 변환
        _df['Date'] = pd.to_datetime(_df['Date'])
        _df.set_index('Date', inplace=True)
    else:
        _df.index = pd.to_datetime(_df.index)

    # 누적수익율 데이터를 생성 
    acc_rtn = 1

    for i in range(_start, _end):
        start = datetime(year = i, month = _month, day = 1)
        end = start + relativedelta(months=5)

        # 구매하는 달 
        buy_mon = start.strftime('%Y-%m')
        # 판매하는 달
        sell_mon = end.strftime('%Y-%m')

        buy = _df.loc[buy_mon].iloc[0]['Open']
        sell = _df.loc[sell_mon].iloc[-1]['Close']

        rtn = sell / buy
        # print(f"매수가 : {buy}, 매도가 : {sell}, 수익율 : {rtn}")
        # 누적수익율 계산
        acc_rtn *= rtn

    return acc_rtn


    