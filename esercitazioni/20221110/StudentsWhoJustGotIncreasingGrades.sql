select s.stid, s.Name
from
    student as s,
    exam as e on s.sid = e.sid
where s.sid not in (
        select e1.sid
        from
            exam as e1,
            exam as e2
        where
            e1.date < e2.date
            and e1.grade > e2.grade
            and e1.stid = e2.stid
    )
group by s.stid -- escludo quelli che hanno solo un esame
having count(*) > 1