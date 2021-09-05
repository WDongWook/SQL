/** Type of Triangle **/

select case 
        when not ((a+b>c) and (a+c>b) and (b+c>a)) then 'Not A Triangle'
        when a = b and b = c then 'Equilateral'
        when a = b or b = c or c = a then 'Isosceles'
        else 'Scalene'
    end as result
from triangles;


/** The PADS **/

select name||'('||substr(occupation,1,1)||')'
from occupations
order by name;

select 'There are a total of ' ||count(occupation)||' ' || lower(occupation) ||'s.'
from occupations
group by occupation
order by count(occupation),occupation;


/** Occupations **/

select min(decode(occupation,'Doctor',name)),min(decode(occupation,'Professor',name)),
min(decode(occupation,'Singer',name)),min(decode(occupation,'Actor',name))
from(select occupation,name,row_number() over(partition by occupation order by name) rn
from occupations)
group by rn
order by 1,2,3,4;


/** Binary Tree Nodes **/

select  n,case when level = 1 then 'Root' when connect_by_isleaf = 1 then 'Leaf' else 'Inner' end as tree_node
from bst
start with p is null
connect by prior n = p
order by n;