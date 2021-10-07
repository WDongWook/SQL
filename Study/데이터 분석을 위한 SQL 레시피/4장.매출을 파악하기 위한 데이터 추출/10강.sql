/* 데이터 테이블 만들기 */

create table purchase_detail_log(dt date, order_id number, user_id varchar(255), item_id varchar(255), price number, category varchar(255), sub_category varchar(255));

insert into purchase_detail_log values('2017-01-18', 48291, 'usr33395', 'lad533', 37300,  'ladys_fashion', 'bag');
insert into purchase_detail_log values('2017-01-18', 48291, 'usr33395', 'lad329', 97300,  'ladys_fashion', 'jacket');
insert into purchase_detail_log values('2017-01-18', 48291, 'usr33395', 'lad886', 33300,  'ladys_fashion', 'bag');
insert into purchase_detail_log values('2017-01-18', 48292, 'usr52832', 'dvd871', 32800,  'dvd', 'documentary');
insert into purchase_detail_log values('2017-01-18', 48291, 'usr33395', 'lad102', 114600, 'ladys_fashion', 'jacket');
insert into purchase_detail_log values('2017-01-18', 48292, 'usr52832', 'gam167', 26000,  'game', 'accessories');
insert into purchase_detail_log values('2017-01-18', 48292, 'usr52832', 'lad289', 57300,  'ladys_fashion', 'bag');
insert into purchase_detail_log values('2017-01-18', 48293, 'usr28891', 'out977', 28600,  'outdoor', 'camp');
insert into purchase_detail_log values('2017-01-18', 48293, 'usr28891', 'boo256', 22500,  'book', 'business');
insert into purchase_detail_log values('2017-01-18', 48293, 'usr28891', 'lad125', 61500,  'ladys_fashion', 'jacket');
insert into purchase_detail_log values('2017-01-18', 48294, 'usr33604', 'mem233', 116300, 'mens_fashion' , 'jacket');
insert into purchase_detail_log values('2017-01-18', 48294, 'usr33604', 'cd477' , 25800,  'cd', 'classic');
insert into purchase_detail_log values('2017-01-18', 48294, 'usr33604', 'boo468', 31000,  'book', 'business');
insert into purchase_detail_log values('2017-01-18', 48294, 'usr33604', 'foo402', 48700,  'food', 'meats');
insert into purchase_detail_log values('2017-01-18', 48295, 'usr38013', 'foo134', 32000,  'food', 'fish');
insert into purchase_detail_log values('2017-01-18', 48295, 'usr38013', 'lad147', 96100,  'ladys_fashion', 'jacket');

select *
from purchase_detail_log;


/* 1. 카테고리별 매출과 소계 계산하기 */

select nvl(category,'all') categories, nvl(sub_category,'all') sub_categories, sum(price) as amount
from purchase_detail_log
group by rollup(category, sub_category)
order by category, sub_category;


/* 2. ABC 분석으로 잘 팔리는 상품 판별하기 */

select a.category, a.amount,round(a.amount / sum(a.amount) over() * 100,3) as ratio, round(100 * sum(a.amount) over(order by amount desc) / sum(amount) over(),3) as cum_ratio, a.rank
from (select category, sum(price) as amount, case ntile(3) over (order by sum(price) desc) when 1 then 'A' when 2 then 'B' else 'C' end as rank 
from purchase_detail_log
group by category
order by sum(price) desc) a;