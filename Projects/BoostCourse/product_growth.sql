/**** 제품 성장률 분석 ****/

/*** 2020년 1월 ~ 6월 데이터 추출 ***/

create table growth as
select s.mem_no, p.category, p.brand, s.sales_qty * p.price as sum_price, case when extract(month from s.order_date) <=3 then '2020년_1분기' else '2020년_2분기' end as quarters
from sales s left join product p
on s.product_code = p.product_code
where extract(year from s.order_date) = 2020 and extract(month from s.order_date) between 1 and 6
order by s.order_date;


/* 확인 */

select *
from growth;


/* 1. 카테고리별 구매금액 분기 성장률 */

select category, round((price_2Q - price_1Q) / price_1Q,2) as product_growth
from (select category, sum(case when quarters = '2020년_1분기' then sum_price end) as price_1Q,
sum(case when quarters = '2020년_2분기' then sum_price end) as price_2Q
from growth
group by category
order by category)
order by product_growth desc;


/* 2. Beauty 카테고리 중 브랜드별 구매지표 */

select brand, sum(sum_price) as brand_price,count(*) as brand_cnt, round(sum(sum_price) / count(*),2) as per_price
from growth
where category = 'beauty'
group by brand
order by per_price desc;