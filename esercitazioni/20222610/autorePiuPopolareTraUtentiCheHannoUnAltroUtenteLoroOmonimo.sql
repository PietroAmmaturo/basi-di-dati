select -- doppie query innestate
    PrimoAut,
    max(NumeroPrestiti)
from (
        select
            Collocazione,
            PrimoAut,
            count(*) AS NumeroPrestiti -- numero di prestiti per ogni autore per utenti con omonimo
        from (
                PRESTITO P
                natural join COPIA
                natural join DATILIBRO
            ) AS Y
        where Y.CodUtente in (
                select
                    CodiceUtente
                from UTENTE
                group by Nome
                having
                    count(*) >= 2
            )
        group by PrimoAut
    )
select PrimoAut, count(*) -- utilizzando ALL per trovare il massimo
from (
        PRESTITO P
        natural join COPIA
        natural join DATILIBRO
    ) AS Y
where Y.CodUtente in (
        select CodiceUtente
        from UTENTE
        group by Nome
        having count(*) >= 2
    )
group by PrimoAut
having count(*) >= ALL (
        select count(*)
        from (
                PRESTITO P
                natural join COPIA
                natural join DATILIBRO
            ) AS Y
        where Y.CodUtente in (
                select
                    CodiceUtente
                from UTENTE
                group by Nome
                having
                    count(*) >= 2
            )
        group by PrimoAut
    )