select
    stid,
    year,
    sum(grade * credits) / sum(credits) as wgpa
from exam
    join course on cid = courseid
where stid in (
        select stid
        from exam
        group by stid
        having count(*) >= 5
    )
group by stid, year;
