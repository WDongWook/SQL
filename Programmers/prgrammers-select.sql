#### ��� ���ڵ� ��ȸ�ϱ�
select *
from animai_ins
order by animal_id asc;


#### ���� �����ϱ�

select name,datetime
from animal_ins
order by animal_id desc;


#### ���� ���� ã��
select animal_id, name
from animal_ins
where intake_condition = 'Sick'
order by animal_id;


#### � ���� ã��

select animal_id, name
from animal_ins
where intake_condition !='Aged'
order by animal_id;


#### ������ ���̵�� �̸�

select animal_id, name
from animal_ins
order by animal_id asc;


#### ���� �������� �����ϱ�

select animal_id, name, datetime
from animal_ins
order by name asc, datetime desc;

#### ���� n�� ���ڵ�

select name
from (select name, datetime
from animal_ins
order by datetime)
where rownum = 1;