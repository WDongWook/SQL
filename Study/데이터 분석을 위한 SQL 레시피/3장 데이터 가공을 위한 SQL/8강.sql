/* 1. ���� ���� ���̺��� ���η� �����ϱ� */

/* 1-1. app1,app2 ������ ���̺� ����� */

create table app2 (user_id varchar(255), name varchar(255), email varchar(255));
create table app1 (user_id varchar(255), name varchar(255), phone varchar(255));

insert into app1 values('U001', 'Ito', '080-xxxx-xxxx');
insert into app1 values('U002', 'Tanaka', '070-xxxx-xxxx');

insert into app2 values('U001', 'Sato', 'sato@example.com');
insert into app2 values('U002', 'Suzuki', 'suzuki@example.com');

/* 1-2. UNION ALL�� �̿��Ͽ� ���̺� ���η� �����ϱ� */

select 'apps1' as app_name, user_id,name, phone from app1
union all
select 'apps2' as app_name, user_id,name, email from app2;


/* 2. ���� ���� ���̺��� ���η� �����ϱ� */

/* 2-1. ī�װ� ������,����,���� ������ ���̺� ����� */

create table mst_categories (category_id varchar(255), name varchar(255));
create table category_sales (category_id varchar(255), sales number);
create table sales_ranking (category_id varchar(255), rank number, product_id varchar(255), sales number);

insert into mst_categories values('1','dvd');
insert into mst_categories values('2','cd');
insert into mst_categories values('3','book');

insert into category_sales values('1',850000);
insert into category_sales values('2',500000);

insert into sales_ranking values('1',1,'D001',50000);
insert into sales_ranking values('1',2,'D002',20000);
insert into sales_ranking values('1',3,'D003',10000);
insert into sales_ranking values('2',1,'C001',30000);
insert into sales_ranking values('2',2,'C002',20000);
insert into sales_ranking values('2',3,'C003',10000);

/* 2-2. �ܼ� INNER JOIN ���� ���̺� ���� */

select m.*,r.rank,r.product_id,r.sales
from mst_categories m join category_sales c 
on m.category_id = c.category_id
join sales_ranking r
on m.category_id = r.category_id
order by m.category_id,m.name,r.rank;

/* 2-3. ������ ���̺��� �� ���� �������� �ʰ� ���� ���� ���̺��� ���η� �����ϱ� */

select m.category_id,m.name,s.sales,r.product_id as top_sale_product
from mst_categories m left join category_sales s
on m.category_id = s.category_id
left join sales_ranking r
on m.category_id = r.category_id and r.rank = 1;