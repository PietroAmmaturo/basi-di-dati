SELECT
    Collocazione,
    count (CodUtente)
FROM
    Copia
    LEFT JOIN Prestito ON Copia.Collocazione = Prestito.Collocazione
GROUP BY
    Copia.Collocazione
SELECT
    Collocazione,
    (
        SELECT
            count (*)
        FROM
            Prestito
        WHERE
            Collocazione = C.Collocazione
    ) AS NumPrest
FROM
    Copia C
GROUP BY
    Copia.Collocazione