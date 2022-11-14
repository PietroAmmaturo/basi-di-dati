select year, max(media)
from mediaStudXAnno M
group by stud

select
    stud,
    year,
    media
from mediaStudXAnno M
where media >= ALL (
        select media
        from mediaStudXAnno
        where stud = M.stud
    )

CREATE VIEW
    mediaStudXAnno(stud, year, media) AS (
        select
            Sid,
            Year,
            sum(Grade * Credits) / sum(Credits)
        from Exam
            join Course on Cid = CourseId
        group by Sid, Year
    )
