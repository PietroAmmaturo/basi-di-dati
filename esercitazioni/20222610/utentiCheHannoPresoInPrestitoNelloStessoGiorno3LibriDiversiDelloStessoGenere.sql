select Nome, Cogn, Codice
from Utente
where Codice in (
        select CodUtente
        from Prestito P
            join Copia C on P.Colloc = C.Colloc
            join DatiLibro D on D.ISBN = C.ISBN
        group by
            CodUtente,
            Genere,
            DataPrestito
        having
            count(distinct D.isbn) = 3
    )