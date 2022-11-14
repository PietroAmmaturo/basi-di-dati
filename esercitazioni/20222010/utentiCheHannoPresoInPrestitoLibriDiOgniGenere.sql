SELECT
    Codice,
    Nome,
    Cognome
FROM
    Utente
    JOIN Prestito P ON Codice = P.CodUtente
    JOIN Copia C ON P.Coll = C.Coll
    JOIN DatiLibro D ON C.ISBN = D.ISBN
GROUP BY
    Codice
HAVING
    count(DISTINCT Genere) = (
        SELECT
            count(DISTINCT Genere)
        FROM
            Datilibro
    )