/* RFM 테이블 만들기 */

create table rfm as
select a.*, b.sum_price, b.cnt
from customer a left join (select s.mem_no, sum(s.sales_qty * p.price) as sum_price, count(s.order_no) as cnt
from sales s left join product p
on s.product_code = p.product_code
where extract(year from s.order_date) = 2020
group by s.mem_no
order by s.mem_no) b
on a.mem_no = b.mem_no;


select *
from rfm;


/* 1. RFM 세분화별 회원수 */

select 세분화, count(mem_no) as cnt
from(select mem_no, case when sum_price >= 5000000 then 'VIP'
when sum_price >= 1000000 or cnt > 3 then '우수'
when sum_price > 0 then '일반'
else '잠재' end as 세분화
from rfm) r
group by 세분화
order by cnt asc;


/* 2. RFM 세분화별 매출액 */

select 세분화, sum(sum_price) as total_price
from (select mem_no,sum_price, case when sum_price >= 5000000 then 'VIP'
when sum_price >= 1000000 or cnt > 3 then '우수'
when sum_price > 0 then '일반'
else '잠재' end as 세분화
from rfm) r
group by 세분화
order by total_price asc;


/* 3. 세분화별 인당 평균 구매액 */

select 세분화,round(sum(sum_price) / count(mem_no),2) as mean_price
from (select mem_no,sum_price,cnt, case when sum_price >= 5000000 then 'VIP'
when sum_price >= 1000000 or cnt > 3 then '우수'
when sum_price > 0 then '일반'
else '잠재' end as 세분화
from rfm) r
group by 세분화
order by mean_price asc;


