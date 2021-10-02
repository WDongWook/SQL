/* 1. 문자열 연결하기 */

/* 1-1. 주소 정보 테이블 만들기 */

create table locations (user_id varchar(255), pref_name varchar(255), city_name varchar(255));

insert into locations values('U001','서울특별시', '강서구');
insert into locations values('U002','경기도수원시','장안구');
insert into locations values('U003','제주특별자치도','서귀포시');

/* 1-2. 문자열 연결 */

select user_id,concat(pref_name,city_name) as pref_city
from locations;

select user_id, pref_name || city_name
from locations;


/* 2. 여러 개의 값 비교하기 */

/* 2-1. 4분기 매출 테이블 만들기 */

create table quarterly_sales (year number(4), q1 number(7), q2 number(7), q3 number(7), q4 number(7));

insert into quarterly_sales values(2015,82000,83000,78000,83000);
insert into quarterly_sales values(2016,85000,85000,80000,81000);
insert into quarterly_sales values(2017,92000,81000,NULL,NULL);

select *
from quarterly_sales;


/* 2-2. 분기별 매출 증감 판정하기 */

select year,q1,q2, case when q2-q1 >0 then '+' when q2-q1 <0 then '-' else ' ' end as judge ,q2-q1 as diff, sign(q2-q1) as signs
from quarterly_sales;

/* 2-3. 연간 최대/최소 4분기 매출 찾기 */

select year,greatest(q1,q2,nvl(q3,0),nvl(q4,0)) as max, least(q1,q2,nvl(q3,1000000),nvl(q4,1000000)) as min
from quarterly_sales;

/* 2-4. 연간 평균 4분기 매출 계산하기 */

select year, (q1+q2+q3+q4) / 4 as avg_sales
from quarterly_sales;

select year,(q1+q2+nvl(q3,0) + nvl(q4,0)) / 4  as avg_sales
from quarterly_sales;


select year, (q1+q2+nvl(q3,0)+nvl(q4,0))  / (sign(coalesce(q1,0))+sign(coalesce(q2,0))+sign(coalesce(q3,0))+sign(coalesce(q4,0))) as avg_sales
from quarterly_sales;


/* 3. 2개의 값 비율 계산하기 */

/* 3-1. 광고 통계 테이블 만들기 */

create table ad_stats (dt date, ad_id varchar(255), impressions number(9), clicks number(6));

insert into ad_stats values('2017-04-01','001',100000,3000);
insert into ad_stats values('2017-04-01','002',120000,1200);
insert into ad_stats values('2017-04-01','003',500000,10000);
insert into ad_stats values('2017-04-02','001',0,0);
insert into ad_stats values('2017-04-02','002',130000,1400);
insert into ad_stats values('2017-04-02','003',620000,15000);

select *
from ad_stats;

/* 3-2. 정수 자료형 데이터 나누기 */

select dt, ad_id, clicks / impressions as ctr, (clicks / impressions) * 100.0 as ctr_percent
from ad_stats
where dt = '2017-04-01';

/* 3-3. 0으로 나누는 것 피하기 */

select dt, ad_id, round(nvl(clicks / decode(impressions,0,null,impressions),0) * 100.0,3) as ctr_percent
from ad_stats;


/* 4. 두 값의 거리 계산하기 */

/* 4-1. 위치 정보 테이블 만들기 */

create table location_1d (x1 number(2), x2 number(2));

insert into location_1d values(5,10);
insert into location_1d values(10,5);
insert into location_1d values(-2,4);
insert into location_1d values(3,3);
insert into location_1d values(0,1);

select *
from location_1d;

/* 4-2. 숫자 데이터의 절댓값, 제곱 평균 제곱근 계산하기 */

select abs(x1-x2) as abs_result, sqrt(power(x1-x2,2)) as rms
from location_1d;

/* 4-3. xy 평면 위에 있는 두 점의 유클리드 거리 계산하기 */

create table location_2d (x1 number(2),y1 number(2), x2 number(2),y2 number(2));

insert into location_2d values(0,0,2,2);
insert into location_2d values(3,5,1,2);
insert into location_2d values(5,3,2,1);

select *
from location_2d;


select round(sqrt(power(x1-x2,2) + power(y1-y2,2)),5) as euclide
from location_2d;


/* 5. 날짜 / 시간 계산하기 */

/* 5-1. 사용자 마스터 테이블 만들기 */

create table smt_user (user_id varchar(255), register_stamp varchar(255), birth_date date);

insert into smt_user values('U001','2016-02-28 10:00:00','2000-02-29');
insert into smt_user values('U002','2016-02-29 10:00:00', '2000-02-29');
insert into smt_user values('U003', '2016-03-01 10:00:00','2000-02-29');

select *
from smt_user;

/* 5-2. 미래 또는 과거의 날짜 / 시간을 계산하는 쿼리 */

select user_id, register_stamp,to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS') as register_date,to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS') + 1 as after_1day,
add_months(to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS'),-1) as before_1month
from smt_user;

/* 5-3. 날짜 데이터들의 차이 계산하기 */

select user_id,to_date('2017-02-05') as today,to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS') as register_date, round(to_date('2017-02-05')-to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS')) as diff_days
from smt_user;

/* 5-4. 사용자의 나이 계산하기 */

select user_id, sysdate as today, extract(year from sysdate) - extract(year from birth_date) +1  as age
from smt_user;


/* 5-5. 등록 시점과 현재 시점 나이 계산하기 */

select user_id, sysdate as today,to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS') as register_date, birth_date,
extract(year from to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS')) - extract(year from birth_date) + 1 as register_age,
extract(year from sysdate) - extract(year from birth_date) +1  as current_age
from smt_user;