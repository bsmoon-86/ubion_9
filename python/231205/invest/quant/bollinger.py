import pandas as pd
from datetime import datetime
import numpy as np

# 첫번째 함수 생성 
def create_band(
        _df, 
        _col = 'Adj Close', 
        _start="2010-01-01", 
        _end = '2023-12-31', 
        _roll = 20
    ):
    # 컬럼에 Date가 존재한다면
    if 'Date' in _df.columns:
        _df.set_index('Date', inplace=True)
    # index를 시계열 변경 
    _df.index = pd.to_datetime(_df.index)

    # 특정 컬럼의 제외하고 모두 제거 
    price_df = _df[[_col]]
    # 결측치, 무한대 값이 존재하는 인덱스 조건식
    flag = price_df.isin([np.nan, np.inf, -np.inf]).any(axis=1)
    # 결측치, 무한대를 제거 
    price_df = price_df.loc[~flag]

    # 이동 평균선 생성
    price_df['center'] = price_df[_col].rolling(_roll).mean()
    # 상단 밴드 생성
    price_df['ub'] = price_df['center'] + (2 * price_df[_col].rolling(_roll).std())
    # 하단 밴드 생성
    price_df['lb'] = price_df['center'] - (2 * price_df[_col].rolling(_roll).std())

    # 시작시간과 종료 시간을 기준으로 필터링 
    start = datetime.strptime(_start, '%Y-%m-%d')
    end = datetime.strptime(_end, '%Y-%m-%d')
    price_df = price_df.loc[start:end]
    return price_df

# 두번째 함수 
def create_trade(_df):
    # 첫번째 함수에서 지정한 컬럼의 이름이 무엇인가? -> _df의 컬럼중 첫번째 데이터
    col = _df.columns[0]

    # 거래 내역 컬럼을 추가 
    _df['trade'] = ""

    # 거래 내역을 추가 
    for i in _df.index:
        # 상단밴드보다 col의 값이 높은 경우
        if _df.loc[i, col] > _df.loc[i, 'ub']:
            _df.loc[i, 'trade'] = ""
        # 하단밴드보다 col의 값이 낮은 경우
        elif _df.loc[i, col] < _df.loc[i, 'lb']:
            _df.loc[i, 'trade'] = 'buy'
        # col의 값이 밴드 사이에 존재한다면
        else:
            # 보유 상태라면 
            if _df.shift().loc[i, 'trade'] == 'buy':
                _df.loc[i, 'trade'] = 'buy'
            else:
                _df.loc[i, 'trade'] = ''
        
    return _df
    

# 세번째 함수 생성 
def create_rtn(_df):
    # 기준이 되는 컬럼의 이름 
    col = _df.columns[0]
    # 수익율 파생변수 생성 데이터는 1로 대입
    _df['rtn'] = 1

    # 수익율 대입 
    for i in _df.index:
        # 구입
        if (_df.shift().loc[i, 'trade'] == "") & \
            (_df.loc[i, 'trade'] == "buy"):
            buy = _df.loc[i, col]
            print(f'매수일 : {i}, 매수가 : {buy}')
        # 판매
        elif (_df.shift().loc[i, 'trade'] == "buy") & \
            (_df.loc[i, 'trade'] == ""):
            sell = _df.loc[i, col]
            # 수익율 발생
            rtn = sell / buy
            # 수익율 대입 
            _df.loc[i, 'rtn'] = rtn
            # 출력 
            print(f'매도일 : {i}, 매도가 : {sell}, 수익율 : {rtn}')
    _df['acc_rtn'] = _df['rtn'].cumprod()
    # 최종 누적수익율을 출력
    print(_df['acc_rtn'][-1])
    return _df