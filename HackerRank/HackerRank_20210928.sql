/* Ollivander's Inventory */

select w.id, p.age, w.coins_needed, w.power
from wands w join wands_property p 
on w.code = p.code
where w.coins_needed = (select min(coins_needed)
                    from wands w2 join wands_property p2 on w2.code = p2.code
                    where p2.is_evil = 0 and w.power = w2.power and p.age = p2.age)
order by w.power desc, p.age desc;


/* Challenges */

select y.hacker_id,x.name, count(*) as challenges_created
from hackers x join challenges y
on x.hacker_id = y.hacker_id
group by y.hacker_id, x.name
having count(*) in (select a.challenges_created
from(select hacker_id, count(*) as challenges_created
from challenges
group by hacker_id) a
group by a.challenges_created
having count(*) = 1) or count(*) = (select max(b.challenges_created)
from (select count(*) as challenges_created
from challenges c join hackers h
on c.hacker_id = h.hacker_id
group by h.hacker_id) b)
order by challenges_created desc, y.hacker_id;