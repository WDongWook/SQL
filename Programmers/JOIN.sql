#### ������ ��� ã��

SELECT ANIMAL_ID, NAME
FROM ANIMAL_OUTS
WHERE ANIMAL_ID NOT IN(SELECT ANIMAL_ID FROM ANIMAL_INS)
ORDER BY ANIMAL_ID;


#### �־��µ��� �������ϴ�

SELECT I.ANIMAL_ID, O.NAME
FROM ANIMAL_INS I INNER JOIN ANIMAL_OUTS O
ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE I.DATETIME > O.DATETIME
ORDER BY I.DATETIME;


#### ���� �Ⱓ ��ȣ�� ����(1)

select name, datetime
from(select name,datetime
from animal_ins
where animal_id not in (select animal_id from animal_outs))
where rownum <=3
order by datetime


#### ��ȣ�ҿ��� �߼�ȭ�� ����

SELECT I.ANIMAL_ID,O.ANIMAL_TYPE, O.NAME 
FROM ANIMAL_INS I INNER JOIN ANIMAL_OUTS O
ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE SEX_UPON_INTAKE LIKE'Intact%' AND (SEX_UPON_OUTCOME LIKE'Spayed%' or sex_upon_outcome Like'Neutered%')
ORDER BY ANIMAL_ID ASC;