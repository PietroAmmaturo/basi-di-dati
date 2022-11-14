select
    sid,
    sum(grade * credits) / sum(credits) as wpga
from exam
    join course on cid = courseid natural right join student
group by sid