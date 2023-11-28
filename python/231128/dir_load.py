import pandas as pd
import os

# _path의 파일 목록을 불러와서 
# _end 확장자로 이루어진 파일들을 모두 결합하여 
# 데이터프레임을 생성하고 해당하는 데이터프레임을 리턴
def data_load(_path, _end, _encoding = 'utf-8'):
    # _path의 마지막 문자열이 '/'가 아니라면 
    # if not(_path.endswith('/')):
    #     # _path = _path + '/'
    #     _path += '/'
    _path += '/'

    # _path의 파일 리스트를 로드 
    file_list = os.listdir(_path)
    # 비어있는 데이터프레임을 생성
    result = pd.DataFrame()
    # file_list를 이용하여 반복문을 생성 
    for file in file_list:
        # file의 확장자가 _end와 같은가?
        if file.split('.')[-1] == _end:
            # _end가 csv라면 -> pd.read_csv()
            # _end가 json이라면 -> pd.read_json()
            if _end == 'csv':
                df = pd.read_csv(_path+file, encoding=_encoding)
            elif _end == 'json':
                df = pd.read_json(_path+file, encoding=_encoding)
            elif _end == 'xml':
                df = pd.read_xml(_path+file, encoding=_encoding)
            elif (_end == 'xlsx') | (_end == 'xls'):
                df = pd.read_excel(_path+file)
            else:
                return "지원하지 않는 확장자입니다."
            # df를 확인 
            print(file , len(df))
            # 데이터프레임의 결합
            result = pd.concat([result, df], axis=0, ignore_index=True)
    return result