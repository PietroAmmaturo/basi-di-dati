select
    sid,
    sum(grade * credits) / sum(credits) as wpga
from exam
group by sid
having count(*) >= 5