/*********** 재구매율 및 구매주기 테이블 만들기 **********/

create table re_table as
select mem_no,첫구매,최근,횟수,case when (최근 - 첫구매) = 0 then 'N' else 'Y' end as 재구매여부, 최근 - 첫구매 as 구매간격, (최근 - 첫구매)  / (횟수-1) as 구매주기 
from(select mem_no, min(order_date) as 첫구매 ,max(order_date) as 최근, count(order_no) as 횟수
from sales
group by mem_no)
order by mem_no;


/* 검증 */

select *
from re_table;


/* 1. 회원(1000021)의 구매정보 */

select *
from re_table
where mem_no = 1000021;

select *
from sales
where mem_no = 1000021;


/* 2. 재구매 회원수 비중(%)*/

select count(mem_no) as 구매회원수, count(case when 재구매여부 ='Y' then mem_no end) as 재구매회원수, round(count(case when 재구매여부 ='Y' then mem_no end) / count(mem_no),2) as 비율
from re_table;


/* 3. 평균 구매주기 및 구매주기 구간별 회원수 */

select round(avg(구매주기),2) as 평균구매주기
from re_table
where 구매주기 > 0;

select 주기기간, count(주기기간) as 구간별_회원수
from(select mem_no,구매주기, case when 구매주기 < 8 then '7일 이내' 
when 구매주기 < 15 then '2주 이내' when 구매주기 < 22 then '3주 이내' 
when 구매주기 < 29 then '4주 이내' else '4주 이상' end as 주기기간
from re_table
where 구매주기 > 0)
group by 주기기간 
order by 구간별_회원수;