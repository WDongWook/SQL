/* Population Census */

select sum(a.population)
from city a inner join country b
on a.countrycode = b.code
where b.continent = 'Asia';


/* African Cities */

select distinct(a.name)
from city a inner join country b
on a.countrycode = b.code
where b.continent = 'Africa';


/* Average Population of Each Continent */

select b.continent, trunc(avg(a.population))
from city a inner join country b
on a.countrycode = b.code
group by b.continent;


/* The Report */

select case when g.grade>=8 then s.name else null end as id, g.grade,s.marks
from students s, grades g
where s.marks between g.min_mark and g.max_mark
order by g.grade desc, s.name,s.marks;


/* Top Competitors */

select hacker_id, name
from(select h.name, x.*
from(select s.*, a.original,a.difficulty_level
from (select c.*,d.score as original
from difficulty d right join challenges c
on c.difficulty_level = d.difficulty_level) a right join submissions s
on a.challenge_id = s.challenge_id) x left join hackers h
on x.hacker_id = h.hacker_id) y
where y.score = y.original
group by hacker_id,name
having count(*)>=2
order by count(*) desc, hacker_id;
