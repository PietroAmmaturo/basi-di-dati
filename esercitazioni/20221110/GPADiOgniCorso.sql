select cid, avg(grade)t, Title, Professor
from exam join course on cid = courseid
group by cid