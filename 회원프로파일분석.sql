#### ���Գ���� ȸ���� ####

select month,count(month) as count
from profile
group by(month)
order by month;

#### ���� ��� ���� / ���� �� ���ɴ뺰 ȸ���� ###

select gender,round(avg(age),2) as avg_age
from profile
group by gender;

select gender, count(gender) as counts
from profile
group by gender
order by gender;

select ages, count(ages) as counts
from profile
group by ages
order by ages;

select gender, ages, count(*) as count
from profile
group by gender,ages
order by gender;


#### ���� �� ���ɴ뺰 ȸ����(���ſ���)#####

select gender,ages,buy, count(mem_no) as cnt_buy
from profile
group by gender,ages,buy
order by buy,gender,ages;