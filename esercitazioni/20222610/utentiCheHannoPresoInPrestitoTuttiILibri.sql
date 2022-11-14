select Codice, Nome, Cognome
from Utente U
where not exists (
        select *
        from Copia C
        where not exists (
                select *
                from Prestito
                where
                    Collocazione = C.Collocazione
                    and CodUtente = U.Codice
            )
    )