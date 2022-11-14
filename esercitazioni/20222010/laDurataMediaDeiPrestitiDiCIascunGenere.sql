SELECT
    Genere,
    avg(DataResa - DataPrestito)
FROM
    Prestito P
    JOIN Copia C ON P.Collocazione = C.Collocazione
    JOIN DatiLibro D ON C.ISBN = D.ISBN
WHERE
    DataResa IS NOT NULL
GROUP BY
    Genere