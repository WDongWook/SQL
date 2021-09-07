/* */

select c.company_code, c.founder, count(distinct l.lead_manager_code),
count(distinct s.senior_manager_code),count(distinct m.manager_code),
count(distinct e.employee_code)
from company c, lead_manager l, senior_manager s, manager m, employee e
where c.company_code = l.company_code and l.lead_manager_code = s.lead_manager_code and s.senior_manager_code = m.senior_manager_code and m.manager_code = e.manager_code
group by c.company_code, c.founder
order by c.company_code;


/* Revising Aggregations - The Count Function */
select count(countrycode)
from city
where population >=100000;


/* Revising Aggregations - The Sum Function */

select sum(population)
from city
where district = 'California';


/* Revising Aggregations - Averages */

select avg(population)
from city
where district = 'California';


/* Average Population */

select round(avg(population))
from city;


/* Japan Population */

select sum(population)
from city 
where countrycode = 'JPN';


/* Population Density Difference */

select max(population) - min(population)
from city;


/* The Blunder */

select ceil(avg(salary) - avg(replace(salary,0,'')))
from employees;

