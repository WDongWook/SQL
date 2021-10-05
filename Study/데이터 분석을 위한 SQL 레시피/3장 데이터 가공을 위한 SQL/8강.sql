/* 1. 여러 개의 테이블을 세로로 결합하기 */

/* 1-1. app1,app2 데이터 테이블 만들기 */

create table app2 (user_id varchar(255), name varchar(255), email varchar(255));
create table app1 (user_id varchar(255), name varchar(255), phone varchar(255));

insert into app1 values('U001', 'Ito', '080-xxxx-xxxx');
insert into app1 values('U002', 'Tanaka', '070-xxxx-xxxx');

insert into app2 values('U001', 'Sato', 'sato@example.com');
insert into app2 values('U002', 'Suzuki', 'suzuki@example.com');

/* 1-2. UNION ALL을 이용하여 테이블 세로로 결합하기 */

select 'apps1' as app_name, user_id,name, phone from app1
union all
select 'apps2' as app_name, user_id,name, email from app2;


/* 2. 여러 개의 테이블을 가로로 정렬하기 */

/* 2-1. 카테고리 마스터,매출,순위 데이터 테이블 만들기 */

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

/* 2-2. 단순 INNER JOIN 통한 테이블 결합 */

select m.*,r.rank,r.product_id,r.sales
from mst_categories m join category_sales c 
on m.category_id = c.category_id
join sales_ranking r
on m.category_id = r.category_id
order by m.category_id,m.name,r.rank;

/* 2-3. 마스터 테이블의 행 수를 변경하지 않고 여러 개의 테이블을 가로로 정렬하기 */

select m.category_id,m.name,s.sales,r.product_id as top_sale_product
from mst_categories m left join category_sales s
on m.category_id = s.category_id
left join sales_ranking r
on m.category_id = r.category_id and r.rank = 1;


/* 3. 조건 플래그를 0과 1로 표현하기 */

/* 3-1. 테이블 만들기 */

create table mst_card(user_id varchar(255), card_number varchar(255));
create table purchase_log(purchase_id varchar(255), user_id varchar(255), amount number(5), stamp varchar(255));

insert into mst_card values('U001','1234-xxxx-xxxx-xxxx');
insert into mst_card values('U002','');
insert into mst_card values('U003','5678-xxxx-xxxx-xxxx');

insert into purchase_log values('10001','U001',200,'2017-01-30 10:00:00');
insert into purchase_log values('10002','U001',500,'2017-02-10 10:00:00');
insert into purchase_log values('10003','U001',200,'2017-02-12 10:00:00');
insert into purchase_log values('10004','U002',800,'2017-03-01 10:00:00');
insert into purchase_log values('10005','U002',400,'2017-03-02 10:00:00');

/* 3-2. 카드 등록과 구매 이력 유무를 0&1 플래그로 나타내는 쿼리 */

select m.user_id, count(p.user_id) as purchase_count, case when m.card_number is not null then 1 else 0 end as has_card,sign(count(p.user_id)) as has_purchased
from mst_card m left join purchase_log p
on m.user_id = p.user_id
group by m.user_id,m.card_number
order by user_id;


/* 4. 계산한 테이블에 이름 붙여 재사용하기 */

create table product_sales(category_name varchar(255), product_id varchar(255), sales number(6));

insert into product_sales values('dvd','D001',50000);
insert into product_sales values('dvd','D002',20000);
insert into product_sales values('dvd','D003',10000);
insert into product_sales values('cd','C001',30000);
insert into product_sales values('cd','C002',20000);
insert into product_sales values('cd','C003',10000);
insert into product_sales values('book','B001',20000);
insert into product_sales values('book','B002',15000);
insert into product_sales values('book','B003',10000);
insert into product_sales values('book','B004',5000);

/* 4-1. 카테고리별 순위 추가하기 */

select category_name, product_id, sales, rank() over(partition by category_name order by sales) as rank
from product_sales;

/* 4-2. 카테고리들 순위에서 유니크한 순위 목록을 계산하는 쿼리 */

select *
from(select distinct rank() over(partition by category_name order by sales) as rank
from product_sales)
order by rank;

/* 4-3. 카테고리들의 순위를 횡단적으로 출력하는 쿼리 */ 

create table product_rank as select category_name, product_id, sales, rank() over(partition by category_name order by sales desc) as rank
from product_sales;

create table rank_df as select *
from(select distinct rank() over(partition by category_name order by sales desc) as rank
from product_sales)
order by rank;

select r.rank, d.category_name as dvd, d.sales as dvd_sales, c.category_name as cd, c.sales as cd_sales,b.category_name as book, b.sales as book_sales
from rank_df r left join (select *
from product_rank 
where category_name = 'dvd') d
on r.rank = d.rank left join (select *
from product_rank 
where category_name = 'cd') c 
on r.rank = c.rank left join (select *
from product_rank 
where category_name = 'book') b
on r.rank = b.rank;
