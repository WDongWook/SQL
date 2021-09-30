/* Placements */

select b.name
from (select f.*,p.salary
from friends f join packages p
on f.friend_id = p.id) a join (select s.*,p.salary
from students s join packages p
on s.id = p.id) b
on a.id = b.id
where b.salary < a.salary
order by a.salary;


/* Symmetric Pairs */

select a.x,a.y
from functions a, functions b
where a.x = b.y and a.y = b.x
group by a.x,a.y
having count(a.x) >1 or a.x < a.y
order by a.x;