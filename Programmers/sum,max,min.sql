#### �ִ� ���ϱ�

select max(datetime) as datetime
from animal_ins
order by datetime desc;


#### �ּڰ� ���ϱ�

select min(datetime) as datetime
from animal_ins;


#### ���� �� ���ϱ�

select count(*) as count
from animal_ins;


#### �ߺ� �����ϱ�

select count(distinct(name)) as count
from animal_ins;