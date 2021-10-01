# 3장 데이터 가공을 위한 SQL

## 5강 하나의 값 조작하기

### 정규표현식 함수

1) regexp_substr
- 문자열내에 일부를 잘라내는 기능

![image](https://user-images.githubusercontent.com/88830472/135563915-634444ac-e7b4-43f0-83f4-a7c78d2f162c.png)
- source_char : 대상 문자열
- pattern : 정규표현식 패턴
- position : 문자열내에서 처음 시작 할 위치
- occurrence : 몇번째 일치할 것인지
- match_param : i(대소문자 무시), c(대소문자 구분)

2) regexp_replace
- 대상문자열에서 특정 문자열 찾아서 다른 문자열로 바꿔주는 기능

![image](https://user-images.githubusercontent.com/88830472/135564075-e0b401bc-2185-47f6-b0bf-903c1acc694f.png)
- source_char : 대상 문자열
- pattern : 정규표현식 패턴
- replace_string : 바꿔치기할 문자열
- position : 문자열내에서 처음 시작 위치
