SELECT
from MediaStudBravi MS
where 9 >= (-- se il numero di studenti con media maggiore del mio studente è minore o uguale a 9 allora il mio studente è nella top 10
        select count(*) -- numero di studenti con media superiore alla media del mio studente
        from MediaStudBravi
        where media > MS.media -- la media del mio studente è minore della media dell'altro studente
    ) -- si seleziaonano le primi 10 medie, in caso di parimerito  si selezionano
create view
    MediaStudBravi(studid, media) as (
        select
            sid,
            sum(grade * credits) / sum(credits) as wpga
        from exam
        group by sid
        having count(*) >= 5
    )