/* 1. ���ڿ� �����ϱ� */

/* 1-1. �ּ� ���� ���̺� ����� */

create table locations (user_id varchar(255), pref_name varchar(255), city_name varchar(255));

insert into locations values('U001','����Ư����', '������');
insert into locations values('U002','��⵵������','��ȱ�');
insert into locations values('U003','����Ư����ġ��','��������');

/* 1-2. ���ڿ� ���� */

select user_id,concat(pref_name,city_name) as pref_city
from locations;

select user_id, pref_name || city_name
from locations;


/* 2. ���� ���� �� ���ϱ� */

/* 2-1. 4�б� ���� ���̺� ����� */

create table quarterly_sales (year number(4), q1 number(7), q2 number(7), q3 number(7), q4 number(7));

insert into quarterly_sales values(2015,82000,83000,78000,83000);
insert into quarterly_sales values(2016,85000,85000,80000,81000);
insert into quarterly_sales values(2017,92000,81000,NULL,NULL);

select *
from quarterly_sales;


/* 2-2. �б⺰ ���� ���� �����ϱ� */

select year,q1,q2, case when q2-q1 >0 then '+' when q2-q1 <0 then '-' else ' ' end as judge ,q2-q1 as diff, sign(q2-q1) as signs
from quarterly_sales;

/* 2-3. ���� �ִ�/�ּ� 4�б� ���� ã�� */

select year,greatest(q1,q2,nvl(q3,0),nvl(q4,0)) as max, least(q1,q2,nvl(q3,1000000),nvl(q4,1000000)) as min
from quarterly_sales;

/* 2-4. ���� ��� 4�б� ���� ����ϱ� */

select year, (q1+q2+q3+q4) / 4 as avg_sales
from quarterly_sales;

select year,(q1+q2+nvl(q3,0) + nvl(q4,0)) / 4  as avg_sales
from quarterly_sales;


select year, (q1+q2+nvl(q3,0)+nvl(q4,0))  / (sign(coalesce(q1,0))+sign(coalesce(q2,0))+sign(coalesce(q3,0))+sign(coalesce(q4,0))) as avg_sales
from quarterly_sales;


/* 3. 2���� �� ���� ����ϱ� */

/* 3-1. ���� ��� ���̺� ����� */

create table ad_stats (dt date, ad_id varchar(255), impressions number(9), clicks number(6));

insert into ad_stats values('2017-04-01','001',100000,3000);
insert into ad_stats values('2017-04-01','002',120000,1200);
insert into ad_stats values('2017-04-01','003',500000,10000);
insert into ad_stats values('2017-04-02','001',0,0);
insert into ad_stats values('2017-04-02','002',130000,1400);
insert into ad_stats values('2017-04-02','003',620000,15000);

select *
from ad_stats;

/* 3-2. ���� �ڷ��� ������ ������ */

select dt, ad_id, clicks / impressions as ctr, (clicks / impressions) * 100.0 as ctr_percent
from ad_stats
where dt = '2017-04-01';

/* 3-3. 0���� ������ �� ���ϱ� */

select dt, ad_id, round(nvl(clicks / decode(impressions,0,null,impressions),0) * 100.0,3) as ctr_percent
from ad_stats;


/* 4. �� ���� �Ÿ� ����ϱ� */

/* 4-1. ��ġ ���� ���̺� ����� */

create table location_1d (x1 number(2), x2 number(2));

insert into location_1d values(5,10);
insert into location_1d values(10,5);
insert into location_1d values(-2,4);
insert into location_1d values(3,3);
insert into location_1d values(0,1);

select *
from location_1d;

/* 4-2. ���� �������� ����, ���� ��� ������ ����ϱ� */

select abs(x1-x2) as abs_result, sqrt(power(x1-x2,2)) as rms
from location_1d;

/* 4-3. xy ��� ���� �ִ� �� ���� ��Ŭ���� �Ÿ� ����ϱ� */

create table location_2d (x1 number(2),y1 number(2), x2 number(2),y2 number(2));

insert into location_2d values(0,0,2,2);
insert into location_2d values(3,5,1,2);
insert into location_2d values(5,3,2,1);

select *
from location_2d;


select round(sqrt(power(x1-x2,2) + power(y1-y2,2)),5) as euclide
from location_2d;


/* 5. ��¥ / �ð� ����ϱ� */

/* 5-1. ����� ������ ���̺� ����� */

create table smt_user (user_id varchar(255), register_stamp varchar(255), birth_date date);

insert into smt_user values('U001','2016-02-28 10:00:00','2000-02-29');
insert into smt_user values('U002','2016-02-29 10:00:00', '2000-02-29');
insert into smt_user values('U003', '2016-03-01 10:00:00','2000-02-29');

select *
from smt_user;

/* 5-2. �̷� �Ǵ� ������ ��¥ / �ð��� ����ϴ� ���� */

select user_id, register_stamp,to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS') as register_date,to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS') + 1 as after_1day,
add_months(to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS'),-1) as before_1month
from smt_user;

/* 5-3. ��¥ �����͵��� ���� ����ϱ� */

select user_id,to_date('2017-02-05') as today,to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS') as register_date, round(to_date('2017-02-05')-to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS')) as diff_days
from smt_user;

/* 5-4. ������� ���� ����ϱ� */

select user_id, sysdate as today, extract(year from sysdate) - extract(year from birth_date) +1  as age
from smt_user;


/* 5-5. ��� ������ ���� ���� ���� ����ϱ� */

select user_id, sysdate as today,to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS') as register_date, birth_date,
extract(year from to_date(register_stamp,'YYYY-MM-DD HH24:MI:SS')) - extract(year from birth_date) + 1 as register_age,
extract(year from sysdate) - extract(year from birth_date) +1  as current_age
from smt_user;