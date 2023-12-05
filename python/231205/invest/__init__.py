# 4개의 투자전력 모듈을 로드
from invest.quant import buyandhold as bnh
from invest.quant import halloween as hw
from invest.quant import bollinger as boll
from invest.quant import momentum as mmt

class Invest:

    # 생성자 함수 
    def __init__(
            self, 
            _data, 
            _col = 'Adj Close', 
            _start = '2010-01-01', 
            _end = '2023-12-31'
        ):
        self.data = _data
        self.col = _col
        self.start = _start
        self.end = _end
    
    # 바이앤홀드 전략 함수를 생성 
    def BuyAndHold(self):
        result, rtn = bnh.buyandhold(
            self.data, 
            self.col, 
            self.start, 
            self.end
        )
        print(f'바이앤홀드 누적 수익율은 {rtn}입니다.')
        return result