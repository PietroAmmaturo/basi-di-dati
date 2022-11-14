select Codice, Nome, Cognome
from Utente U
where not exists (
        select *
        from DatiLibro D
        where not exists (
                select *
                from
                    Prestito P
                    join Copia C on P.Coll = C.Coll
                    join DatiLibro D1 on C.Isbn = D1.Isbn
                where
                    CodUtente = U.Codice
                    and Genere = D.Genere
            )
    )
select
    Codice,
    Nome,
    Cognome
from Utente
    join Prestito P on Codice = CodUtente
    join Copia C on P.Coll = C.Coll
    join DatiLibro D on C.Isbn = D.Isbn
group by
    Codice,
    Nome,
    Cognome
having
    count(distinct Genere) = (
        select count(distinct Genere)
        from Datilibro
    )