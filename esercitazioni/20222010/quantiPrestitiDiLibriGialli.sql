SELECT
    count(*)
FROM
    Prestito P
    JOIN Copia C ON P.Collocazione = C.Collocazione
SELECT
    ISBN
FROM
    DATILIBRO
WHERE
    Genere = "Giallo"