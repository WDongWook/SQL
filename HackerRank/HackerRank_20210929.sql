/* Contest Leaderboard */

select s.hacker_id, h.name, sum(max_score)
from(select hacker_id, challenge_id, max(score) as max_score
from submissions
where score != 0
group by hacker_id, challenge_id) s join hackers h
on s.hacker_id = h.hacker_id
group by s.hacker_id, h.name
order by sum(max_score) desc, s.hacker_id;


/* SQL Project Planning */

select a.start_date, max(a.end_date) as max_date
from (select connect_by_root start_date as start_date, end_date
from projects
start with start_date in (select start_date
from projects
where start_date not in (select end_date from projects))
connect by prior end_date = start_date) a
group by a.start_date
order by to_date(max_date) - to_date(a.start_date), a.start_date;