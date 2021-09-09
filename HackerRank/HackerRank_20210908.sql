/* Weather Observation Station 7 */

select distinct city
from station
where substr(city,length(city),1) in ('a','e','i','o','u');


/* Weather Observation Station 13 */ 

select sum(lat_n)
from station
where lat_n between 38.7880 and 137.2345;


/* Weather Observation Station 14 */

select round(max(lat_n),4)
from station
where lat_n < 137.2345;


/* Weather Observation Station 15 */

select round(long_w,4)
from station
where lat_n = (select max(lat_n) from station where lat_n < 137.2345);


/* Weather Observation Station 16 */

select round(min(lat_n),4)
from station
where lat_n > 38.7780;