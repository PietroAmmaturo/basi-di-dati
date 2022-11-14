from exam E
    join course on cid = courseid
    natural join student
where year = 2
group by stid
having count(*) > (
        select count(*)
        from exam
            join course on cid = courseid
        where
            year = 1
            and E.sid = sid
    )