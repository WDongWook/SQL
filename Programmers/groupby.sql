#### ����̿� ���� �� ���� ������?

select animal_type,count(animal_type) as "count"
from animal_ins
group by animal_type
order by animal_type;


#### ���� ���� �� ã��

select name, name_cnt
from(select name, count(name) as name_cnt
from animal_ins
where name is not null
group by name)
where name_cnt >1 
order by name;


#### �Ծ� �ð� ���ϱ�(1)

select hour, count(*) as count
from(select to_char(datetime,'HH24') as hour
from animal_outs
where to_char(datetime,'HH24') between 09 and 19)
group by hour
order by hour;

#### �Ծ� �ð� ���ϱ�(2)

select i.hour, nvl(a.count,0) as count
from (select to_char(datetime,'hh24') as hour, count(*) as count
from animal_outs
group by to_char(datetime,'hh24')) a, (SELECT LEVEL-1 AS hour 
FROM dual CONNECT BY LEVEL<=24) i
where a.hour(+)=i.hour
order by i.hour asc;