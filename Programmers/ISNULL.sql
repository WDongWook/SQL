#### �̸��� ���� ������ ���̵�

select animal_id
from animal_ins
where name is null
order by animal_id asc;


#### �̸��� �ִ� ������ ���̵�

select animal_id
from animal_ins
where name is not null
order by animal_id;


#### NULL ó���ϱ�

select animal_type, nvl(name,'No name') as name, sex_upon_intake
from animal_ins
order by animal_id;