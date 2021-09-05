/**** ��ǰ ����� �м� ****/

/*** 2020�� 1�� ~ 6�� ������ ���� ***/

create table growth as
select s.mem_no, p.category, p.brand, s.sales_qty * p.price as sum_price, case when extract(month from s.order_date) <=3 then '2020��_1�б�' else '2020��_2�б�' end as quarters
from sales s left join product p
on s.product_code = p.product_code
where extract(year from s.order_date) = 2020 and extract(month from s.order_date) between 1 and 6
order by s.order_date;


/* Ȯ�� */

select *
from growth;


/* 1. ī�װ��� ���űݾ� �б� ����� */

select category, round((price_2Q - price_1Q) / price_1Q,2) as product_growth
from (select category, sum(case when quarters = '2020��_1�б�' then sum_price end) as price_1Q,
sum(case when quarters = '2020��_2�б�' then sum_price end) as price_2Q
from growth
group by category
order by category)
order by product_growth desc;


/* 2. Beauty ī�װ� �� �귣�庰 ������ǥ */

select brand, sum(sum_price) as brand_price,count(*) as brand_cnt, round(sum(sum_price) / count(*),2) as per_price
from growth
where category = 'beauty'
group by brand
order by per_price desc;