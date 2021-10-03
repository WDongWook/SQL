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

#### 정규식 주요 패턴

- [] : []안에 있는 문자 중 하나를 일치시키려는 목록 지정
- () : 표현식을 하위 표현식으로 그룹화
- ^ : 문자열의 시작 부분과 일치
- $ : 문자열의 끝 부분과 일치
- * : 0개 이상 일치
- + : 하나 이상 일치
- ? : 0 or 1개 일치
- . : NULL을 제외한 모든 문자와 일치


## 6강 여러 개의 값에 대한 조작

### ORA-01476 해결 방법

- 원인은 나눌때 분모가 0이어서 발생
- 해결방법은 분모가 0이 안되게 함수를 만드는 것
- ex) nvl(분자 / decode(분모,0,null,분모),0) from 테이블;

#### Decode 함수

- Oracle에서만 사용가능한 함수
- Decode(표현식, 기준값1, 출력값1, 기준값2, 출력값2,---------,Default 값)
- 표현식의 값이 기준값1이면 출력값1 출력,-----, 기준값이 없으면 Default값 출력
- ex) decode(position, 'GK', 골키퍼, 'DF',수비수, 'MF','미드필더','FW',공격수,'그 외')

### 날짜 계산하기

#### 1) interval 함수를 통해 계산할 수 있다.
- ex) sysdate + (interval '1', year) -> 현재 날짜에 1년 더하기
- 년,월,일,시간,분,초 다 사용가능하다.

#### 2) 그냥 기본적인 계산 방법
- ex) sysdate + 5/24 -> 현재 날짜에 5시간 더하기
- ex) sysdate + 5/(24*60) -> 5분 더하기
- ex) sysdate + 5/(24*60*60) -> 5초 더하기

#### 3) add_months 함수를 통한 월 계산 가능
- ex) add_months(sysdate,1) -> 현재 날짜에 한 달 더하기


## 7강 하나의 테이블에 대한 조작하기

### 1. 그룹의 특징 잡기

#### 집약 함수 : 여러 레코드를 기반으로 하나의 값을 리턴해주는 함수 
- ex) count, sum, avg 등

- group by 구문을 사용한 쿼리에서는 group by 구문에 지정한 칼럼 or 집약 함수만 select 구문의 컬럼으로 지정할 수 있다.

### 2. 그룹 내부의 순서

- SQL의 테이블은 기본적으로 순서라는 개념이 없다. -> 윈도우 함수를 통해 다루면 된다.

#### WINDOWING 절
- 함수의 대상이 되는 행 기준의 범위를 지정한다.
- ROWS : 행의 수를 기준으로 한 범위
- RANGE : 값의 기준으로 한 범위

예시
- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING : 앞의 한 행, 현재 행, 뒤의 한 행을 범위로 지정
- RANGE BETWEEN 50 PRECEDING AND 150 FOLLOWING : 현재 행의 값 -50 ~ 현재 행의 값 + 150을 범위로 지정
- RANGE UNBOUNDED PRECEDING : 첫 행 ~ 현재 행까지 지정
- UNBOUNDED PRECEDING : 이전 행 전부
- UNBOUNDED FOLLOWING : 이후 행 전부

### 3. 세로 기반 데이터를 가로 기반으로 변환하기

#### listagg 함수

- listagg([칼럼명], [구분자]) within group(order by [정렬 칼럼명])
- ex) listagg(product_id,',') within group(order by score product_id) : product_id를 배열에 집약하고 쉼표로 구분한다. 또한, product_id를 오름차순으로 정렬
