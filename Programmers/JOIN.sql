#### 없어진 기록 찾기

SELECT ANIMAL_ID, NAME
FROM ANIMAL_OUTS
WHERE ANIMAL_ID NOT IN(SELECT ANIMAL_ID FROM ANIMAL_INS)
ORDER BY ANIMAL_ID;


#### 있었는데요 없었습니다

SELECT I.ANIMAL_ID, O.NAME
FROM ANIMAL_INS I INNER JOIN ANIMAL_OUTS O
ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE I.DATETIME > O.DATETIME
ORDER BY I.DATETIME;


#### 오랜 기간 보호한 동물(1)

select name, datetime
from(select name,datetime
from animal_ins
where animal_id not in (select animal_id from animal_outs))
where rownum <=3
order by datetime


#### 보호소에서 중성화한 동물

SELECT I.ANIMAL_ID,O.ANIMAL_TYPE, O.NAME 
FROM ANIMAL_INS I INNER JOIN ANIMAL_OUTS O
ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE SEX_UPON_INTAKE LIKE'Intact%' AND (SEX_UPON_OUTCOME LIKE'Spayed%' or sex_upon_outcome Like'Neutered%')
ORDER BY ANIMAL_ID ASC;