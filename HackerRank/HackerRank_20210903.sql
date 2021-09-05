#### Revising the Select Query I

select *
from city
where population >=100000 and countrycode ='USA';


#### Revising the Select Query II

select name
from city
where population>=120000 and countrycode ='USA';


#### Select All

select *
from city;


#### select By ID

select *
from city
where id = 1661;


#### Japanese Cities' Attributes

select *
from city
where countrycode = 'JPN';


#### Japanese Cities' Names

select name
from city
where countrycode = 'JPN';


#### Weather Observation Station 1

select city, state
from station;


#### Weather Observation Station 3

select distinct city
from station
where mod(id,2)=0;


#### Weather Observation Station 4

select count(*)-count(distinct city)
from station;


#### Weather Observation Station 5
select city, length(city)
from (select city, length(city)
     from station
     order by length(city),city)
where rownum=1;

select city, length(city)
from (select city, length(city)
     from station
     order by length(city) desc, city)
where rownum = 1;


#### Weather Observation Station 6

select distinct city
from(select city,substr(city,1,1) as first
from station)
where lower(first) in ('a','e','i','o','u');


#### Weather Observation Station 8

select distinct city
from station
where lower(substr(city,1,1)) in ('a','e','i','o','u') 
and lower(substr(city,length(city),1)) in ('a','e','i','o','u');


#### Weather Observation Station 9

select distinct city
from station
where lower(substr(city,1,1)) not in ('a','e','i','o','u');


#### Weather Observation Station 10

select distinct city
from station
where lower(substr(city,length(city),1)) not in ('a','e','i','o','u');


#### Weather Observation Station 11

select distinct city
from station
where lower(substr(city,1,1)) not in ('a','e','i','o','u') 
or lower(substr(city,length(city),1)) not in ('a','e','i','o','u');


#### Weather Observation Station 12

select distinct city
from station
where lower(substr(city,1,1)) not in ('a','e','i','o','u') 
and lower(substr(city,length(city),1)) not in ('a','e','i','o','u');


#### Higher Than 75 Marks

select name
from students
where marks > 75
order by substr(name,length(name)-2,3), id;


#### Employee Names

select name
from employee
order by name;


#### Employee Salaries

select name
from employee
where months <10 and salary >=2000;
