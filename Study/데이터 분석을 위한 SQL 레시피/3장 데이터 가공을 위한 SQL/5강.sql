
/* mst ���̺� ���� */

create table mst (user_id varchar(255), register_date varchar(255),register_device number);
insert into mst values('U001', '2016-08-26', 1);
insert into mst values('U002', '2016-08-26', 2);
insert into mst values('U003', '2016-08-27', 3);

select *
from mst;


/* 1. �ڵ� ���� ���̺�� �����ϱ� */

select user_id, case register_device when 1 then '����ũž' when 2 then '����Ʈ��' 
when 3 then '���ø����̼�' else '' end as device_name
from mst;


/* 2. URL���� ��� �����ϱ� */

/* 2.1 access_log ���̺� ���� */

create table access_log (stamp varchar(255), referrer varchar(255), urls varchar(255));

insert into access_log values('2016-08-26 12:02:00', 'http://www.other.com/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video/detail?id=001');
insert into access_log values('2016-08-26 12:02:01', 'http://www.other.net/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video#ref');
insert into access_log values('2016-08-26 12:02:01', 'https://www.other.com/', 'http://www.example.com/book/detail?id=002' );

select *
from access_log;


/* 2.2 ���۷� �������� ���� */

select stamp,regexp_replace(regexp_substr(referrer,'https?://[^/]*'),'https?://','') as refferer_host
from access_log;


/* 2.3 url ��ο� get �Ű������� �ִ� Ư�� Ű �� ���� */

select stamp,urls,regexp_replace(regexp_substr(urls,'//[^/]+[^?#]+'),'//[^/]+','') as path,
REGEXP_REPLACE(regexp_substr(urls,'id=[^&]*'),'id=','') as id
from access_log;


/* 3. ���ڿ��� �迭�� �����ϱ� */

select stamp,urls,regexp_substr(regexp_replace(regexp_substr(urls,'//[^/]+[^?#]+'),'//[^/]+',''),'[^/]+') as path1
from access_log;


/* 4. ��¥�� Ÿ�ӽ����� �ٷ�� */

select sysdate,to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;


/* 4.1 ��¥/�ð����� Ư�� �ʵ� ���� */

select extract(year from sysdate) as year, extract(month from sysdate) as month, extract(day from sysdate) as day
from dual;


/* 5. �������� default ������ ��ü */

/* 5.1 ���̺� ���� */

create table purchase_log (purchase_id varchar(255), amount number, coupon number);

insert into purchase_log values('10001',3280, null);
insert into purchase_log values('10002',4650, 500);
insert into purchase_log values('10003',3870, null);


/* 5.2 ���ž׿��� ���� ���� ���� ������ ���� �ݾ� ���ϱ� */

select purchase_id, amount, coupon, amount - nvl(coupon,0) as discount_amount
from purchase_log;