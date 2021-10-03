/* 1. �׷��� Ư¡ ��� */

/* 1.1 ��ǰ �� ���̺� ����� */

create table review(user_id varchar(255), product_id varchar(255), score float);

insert into review values('U001','A001',4.0);
insert into review values('U001','A002',5.0);
insert into review values('U001','A003',5.0);
insert into review values('U002','A001',3.0);
insert into review values('U002','A002',3.0);
insert into review values('U002','A003',4.0);
insert into review values('U003','A001',5.0);
insert into review values('U003','A002',4.0);
insert into review values('U003','A003',4.0);

select *
from review;

/* 1-2. ���̺� ��ü�� Ư¡�� ��� */

select count(*) as total_count, count(distinct user_id) as user_count, count(distinct product_id) as product_count, sum(score) as sum_score,
round(avg(score),2) as avg_score, max(score) as max_score, min(score) as min_score
from review;

/* 1-3. �׷����� �������� Ư¡�� ����ϱ� */

select user_id,count(*) as total_count, count(distinct user_id) as user_count, count(distinct product_id) as product_count, sum(score) as sum_score,
round(avg(score),2) as avg_score, max(score) as max_score, min(score) as min_score
from review
group by user_id;

/* 1-4. ���� �Լ��� ������ ���� ���� ���� ���� ���ÿ� �ٷ�� */

select user_id, product_id, score, round(avg(score) over(),2) as avg_score, round(avg(score) over(partition by user_id),2) as user_avg_score, score - round(avg(score) over(partition by user_id),2) as avg_user_diff
from review;


/* 2. �׷� ������ ���� */

/* 2-1. �α� ��ǰ ���̺� ����� */

create table popular_products(product_id varchar(255), category varchar(255), score float);

insert into popular_products values('A001','action',94);
insert into popular_products values('A002','action',81);
insert into popular_products values('A003','action',78);
insert into popular_products values('A004','action',64);
insert into popular_products values('D001','drama',90);
insert into popular_products values('D002','drama',82);
insert into popular_products values('D003','drama',78);
insert into popular_products values('D004','drama',58);

select *
from popular_products;

/* 2-2. ORDER BY �������� ���� �����ϱ� */

select product_id, score, row_number() over(order by score desc) as row_num, rank() over (order by score desc) as rank,
dense_rank() over(order by score desc) as dense_rank,lag(product_id) over(order by score desc) as lag1, lead(product_id) over(order by score desc) as lead1
from popular_products
order by row_num;

/* 2-3. ORDER BY ������ ���� �Լ� �����ϱ� */

select product_id, score, row_number() over(order by score desc) as row_num, sum(score) over(order by score desc rows between unbounded preceding and current row) as cum_score,
round(avg(score) over(order by score desc rows between 1 preceding and 1 following),2) as local_avg, 
first_value(product_id) over(order by score desc rows between unbounded preceding and unbounded following) as first_value,
last_value(product_id) over(order by score desc rows between unbounded preceding and unbounded following) as last_value
from popular_products;

/* 2-4. PARTITION BY & ORDER BY �����ϱ� */

select category, product_id,score,row_number() over(partition by category order by score desc) as row_num,
rank() over(partition by category order by score desc) as rank, dense_rank() over(partition by category order by score desc) as dense_rank
from popular_products;

/* 2-5. �� ī�װ��� ���� n�� �����ϱ� */

select *
from(select category, product_id, score, rank() over(partition by category order by score desc) as rank
from popular_products)
where rank<=2;

/* 2-6. ī�װ��� ���� �ֻ��� ��ǰ�� �����ϱ� */

select category,product_id
from(select category, product_id, score, rank() over(partition by category order by score desc) as rank
from popular_products)
where rank=1;


/* 3. ���� ��� �����͸� ���� ������� ��ȯ�ϱ� */

/* 3-1. ��¥�� KPI ������ ���̺� ����� */

create table daily_kpi (dt date, indicator varchar(255), val number(5));

insert into daily_kpi values('2017-01-01', 'impressions', 1800);
insert into daily_kpi values('2017-01-01','sessions',500);
insert into daily_kpi values('2017-01-01','users',200);
insert into daily_kpi values('2017-01-02','impressions',2000);
insert into daily_kpi values('2017-01-02','sessions',700);
insert into daily_kpi values('2017-01-02','users',250);

select *
from daily_kpi;

/* 3-2. ���� ���� ��ȯ�ϱ� */

select dt, max(case when indicator = 'impressions' then val end) as impressions, max(case when indicator = 'sessions' then val end) as sessions,
max(case when indicator = 'users' then val end) as users
from daily_kpi
group by dt
order by dt;

/* 3-3. ���� ��ǥ�� ������ ���ڿ��� �����ϱ� */

/* 3-3-1. ���� �� �α� ���̺� ����� */

create table purchase_df (purchase_id varchar(255), product_id varchar(255), price number(4));

insert into purchase_df values('100001','A001',300);
insert into purchase_df values('100001','A002',400);
insert into purchase_df values('100001','A003',200);
insert into purchase_df values('100002','D001',500);
insert into purchase_df values('100002','D002',300);
insert into purchase_df values('100002','A001',300);

select *
from purchase_df;

/* 3-3-2. �� �����ؼ� ��ǥ�� ���е� ���ڿ��� ��ȯ�ϱ� */

select purchase_id,listagg(product_id,',') within group(order by product_id) as product_ids,sum(price) as amount
from purchase_df
group by purchase_id
order by purchase_id;
