#### 이름이 없는 동물의 아이디

select animal_id
from animal_ins
where name is null
order by animal_id asc;


#### 이름이 있는 동물의 아이디

select animal_id
from animal_ins
where name is not null
order by animal_id;


#### NULL 처리하기

select animal_type, nvl(name,'No name') as name, sex_upon_intake
from animal_ins
order by animal_id;