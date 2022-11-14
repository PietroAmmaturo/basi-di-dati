select sid
from mediaStud
where media >= 2 + (
        select avg(media)
        from mediaStud
    )
CREATE VIEW
    mediaStud(stud, media) AS (
        select
            stid,
            sum(grade * credits) / sum(credits)
        from exam
            join course on cid = courseid
        group by stid
    )