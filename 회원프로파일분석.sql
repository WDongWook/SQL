#### 가입년월별 회원수 ####

select month,count(month) as count
from profile
group by(month)
order by month;

#### 성별 평균 연령 / 성별 및 연령대별 회원수 ###

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


#### 성별 및 연령대별 회원수(구매여부)#####

select gender,ages,buy, count(mem_no) as cnt_buy
from profile
group by gender,ages,buy
order by buy,gender,ages;