import pandas as pd
import numpy as np

# 첫번째 함수
def create_ym(_df, _col = 'Adj Close'):
    # Date 컬럼이 존재한다면 index로 변경
    if 'Date' in _df.columns:
        _df.set_index('Date', inplace=True)
    # index를 시계열 데이터로 변경
    _df.index = pd.to_datetime(_df.index)

    # 기준이 되는 컬럼을 제외하고 모두 제거 
    _df = _df[[_col]]

    _df['STD-YM'] = _df.index.map(
        lambda x : x.strftime('%Y-%m')
    )

    return _df

# 두번째 함수
def create_month_last(_df, _momentum = 12, _start = '2010-01-01'):
    result = pd.DataFrame()
    ym_list = _df['STD-YM'].unique()
    for i in ym_list:
        flag = _df['STD-YM'] == i
        data = _df.loc[flag].tail(1)
        result = pd.concat([result, data], axis=0)
    # result = _df.loc[_df.shift(-1)['STD-YM'] != _df['STD-YM']]
    # 파생변수 생성 
    # 전월의 데이터
    # 기준이 되는 컬럼의 이름
    col = _df.columns[0]
    result['BF1'] = result.shift(1)[col].fillna(0)
    result['BF2'] = result.shift(_momentum)[col].fillna(0)
    # 시작 시간부터 마지막 데이터까지 필터링 
    result = result.loc[_start:]
    return result

def create_trade(_df1, _df2, _score = 1):
    _df1['trade'] = ""
    _df1['rtn'] = 1

    # momentum_index를 생성
    for i in _df2.index:
        signal = ""

        # 절대 모멘텀을 계산
        momentum_index = _df2.loc[i, 'BF1'] / _df2.loc[i, 'BF2'] - _score

        # momentum_index가 0보다 크고 무한대가 아닐때 구매 조건
        flag = (momentum_index > 0) & (momentum_index != np.inf)

        if flag :
            signal = 'buy'
        # _df1의 trade에 signal 대입 
        _df1.loc[i:, 'trade'] = signal
        print(f'''날짜 : {i}, 모멘텀 인덱스 : , {momentum_index}, 
              flag : {flag}, signal : {signal}''')
    return _df1

# 네번째 함수 
def create_rtn(_df):
    col = _df.columns[0]

    for i in _df.index:
        # 구매한 날 조건식 
        if (_df.shift().loc[i, 'trade'] == '') & (_df.loc[i, 'trade'] == 'buy'):
            buy = _df.loc[i, col]
            print(f'매수일 : {i}, 매수가 : {buy}')
        # 판매한 날 조건식
        elif (_df.shift().loc[i, 'trade'] == 'buy') & (_df.loc[i, 'trade'] == ''):
            sell = _df.loc[i, col]
            rtn = sell / buy
            _df.loc[i, 'rtn'] = rtn
            print(f'매도일 : {i}, 매도가 : {sell}, 수익율 : {rtn}')

    # 누적수익율 계산
    _df['acc_rtn'] = _df['rtn'].cumprod()

    print(_df['acc_rtn'].iloc[-1])
    return _df