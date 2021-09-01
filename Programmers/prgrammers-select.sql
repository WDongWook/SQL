#### 모든 레코드 조회하기
select *
from animai_ins
order by animal_id asc;


#### 역순 정렬하기

select name,datetime
from animal_ins
order by animal_id desc;


#### 아픈 동물 찾기
select animal_id, name
from animal_ins
where intake_condition = 'Sick'
order by animal_id;


#### 어린 동물 찾기

select animal_id, name
from animal_ins
where intake_condition !='Aged'
order by animal_id;


#### 동물의 아이디와 이름

select animal_id, name
from animal_ins
order by animal_id asc;


#### 여러 기준으로 정렬하기

select animal_id, name, datetime
from animal_ins
order by name asc, datetime desc;

#### 상위 n개 레코드

select name
from (select name, datetime
from animal_ins
order by datetime)
where rownum = 1;