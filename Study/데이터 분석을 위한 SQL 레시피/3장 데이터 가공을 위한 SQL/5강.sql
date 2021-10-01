
/* mst 테이블 생성 */

create table mst (user_id varchar(255), register_date varchar(255),register_device number);
insert into mst values('U001', '2016-08-26', 1);
insert into mst values('U002', '2016-08-26', 2);
insert into mst values('U003', '2016-08-27', 3);

select *
from mst;


/* 1. 코드 값을 레이블로 변경하기 */

select user_id, case register_device when 1 then '데스크탑' when 2 then '스마트폰' 
when 3 then '애플리케이션' else '' end as device_name
from mst;


/* 2. URL에서 요소 추출하기 */

/* 2.1 access_log 테이블 생성 */

create table access_log (stamp varchar(255), referrer varchar(255), urls varchar(255));

insert into access_log values('2016-08-26 12:02:00', 'http://www.other.com/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video/detail?id=001');
insert into access_log values('2016-08-26 12:02:01', 'http://www.other.net/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video#ref');
insert into access_log values('2016-08-26 12:02:01', 'https://www.other.com/', 'http://www.example.com/book/detail?id=002' );

select *
from access_log;


/* 2.2 레퍼러 도메인을 추출 */

select stamp,regexp_replace(regexp_substr(referrer,'https?://[^/]*'),'https?://','') as refferer_host
from access_log;


/* 2.3 url 경로와 get 매개변수에 있는 특정 키 값 추출 */

select stamp,urls,regexp_replace(regexp_substr(urls,'//[^/]+[^?#]+'),'//[^/]+','') as path,
REGEXP_REPLACE(regexp_substr(urls,'id=[^&]*'),'id=','') as id
from access_log;


/* 3. 문자열을 배열로 분해하기 */

select stamp,urls,regexp_substr(regexp_replace(regexp_substr(urls,'//[^/]+[^?#]+'),'//[^/]+',''),'[^/]+') as path1
from access_log;


/* 4. 날짜와 타임스탬프 다루기 */

select sysdate,to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;


/* 4.1 날짜/시각에서 특정 필드 추출 */

select extract(year from sysdate) as year, extract(month from sysdate) as month, extract(day from sysdate) as day
from dual;


/* 5. 결측값을 default 값으로 대체 */

/* 5.1 테이블 생성 */

create table purchase_log (purchase_id varchar(255), amount number, coupon number);

insert into purchase_log values('10001',3280, null);
insert into purchase_log values('10002',4650, 500);
insert into purchase_log values('10003',3870, null);


/* 5.2 구매액에서 할인 쿠폰 값을 제외한 매출 금액 구하기 */

select purchase_id, amount, coupon, amount - nvl(coupon,0) as discount_amount
from purchase_log;