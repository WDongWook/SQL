#### ��ÿ� ���� ã��

SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ('Lucy','Ella','Pickle','Rogan','Sabrina','Mitty')
ORDER BY ANIMAL_ID;


#### �̸��� el�� ���� ���� ã��

SELECT animal_id, name
from animal_ins
where lower(name) like '%el%' and animal_type ='Dog'
order by name asc;


#### �߼�ȭ ���� �ľ��ϱ�

SELECT ANIMAL_ID,NAME,
    CASE
        WHEN SEX_UPON_INTAKE LIKE '%Neutered%' THEN 'O'
        WHEN SEX_UPON_INTAKE LIKE '%Spayed%' THEN 'O'
        ELSE 'X'
        END AS �߼�ȭ
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;


#### �����Ⱓ ��ȣ�� ����(2)

select animal_id, name
from (select i.animal_id, o.name
    from animal_ins i inner join animal_outs o
on i.animal_id = o.animal_id
order by o.datetime - i.datetime desc)
where rownum <=2;


#### DATETIME���� DATE�� �� ��ȯ

SELECT animal_id, name,to_char(datetime, 'YYYY-MM-DD') as "��¥"
from animal_ins
order by animal_id asc;