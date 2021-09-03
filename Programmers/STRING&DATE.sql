#### 루시와 엘라 찾기

SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ('Lucy','Ella','Pickle','Rogan','Sabrina','Mitty')
ORDER BY ANIMAL_ID;


#### 이름에 el이 들어가는 동물 찾기

SELECT animal_id, name
from animal_ins
where lower(name) like '%el%' and animal_type ='Dog'
order by name asc;


#### 중성화 여부 파악하기

SELECT ANIMAL_ID,NAME,
    CASE
        WHEN SEX_UPON_INTAKE LIKE '%Neutered%' THEN 'O'
        WHEN SEX_UPON_INTAKE LIKE '%Spayed%' THEN 'O'
        ELSE 'X'
        END AS 중성화
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;


#### 오랜기간 보호한 동물(2)

select animal_id, name
from (select i.animal_id, o.name
    from animal_ins i inner join animal_outs o
on i.animal_id = o.animal_id
order by o.datetime - i.datetime desc)
where rownum <=2;


#### DATETIME에서 DATE로 형 변환

SELECT animal_id, name,to_char(datetime, 'YYYY-MM-DD') as "날짜"
from animal_ins
order by animal_id asc;