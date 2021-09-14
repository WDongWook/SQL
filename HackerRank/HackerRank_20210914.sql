/* Top Earners */

select months * salary as earnings, count(*)
from employee
where months * salary = (select max(months * salary)
from employee)
group by (months * salary);


/* Weather Observation Station 2 */

select round(sum(lat_n),2) as lat, round(sum(long_w),2) as lon 
from station;


/* Weather Observation Station 16 */

select round(min(lat_n),4)
from station
where lat_n > 38.7780;


/* Weather Observation Station 17 */

select round(long_w,4)
from station
where lat_n = (select min(lat_n)
from station
where lat_n > 38.7780);


/* Weather Observation Station 18(Manhattan Distance) */ 

select round(abs(max(lat_n) - min(lat_n)) + abs(max(long_w) - min(long_w)),4)
from station;


/* Weather Observation Station 19 (Euclidean Distance) */

select round(sqrt(power(min(long_w)-max(long_w),2) + power(min(lat_n)-max(lat_n),2)),4)
from station;


/* Weather Observation Station 20 */

select round(median(lat_n),4)
from station;