SELECT
    Genere,
    avg(DataResa - DataPrestito)
FROM
    Utente U
    JOIN Prestito P ON U.Codice = P.CodUtente
    JOIN Copia C ON P.Collocazione = C.Collocazione
WHERE
    DataResa IS NOT NULL
GROUP BY
    CodUtente
HAVING count(*) >= 10