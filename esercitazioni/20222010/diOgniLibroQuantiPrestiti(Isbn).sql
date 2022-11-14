SELECT
    ISBN,
    count (CodUtente)
FROM
    Copia
    LEFT JOIN Prestito ON Copia.Collocazione = Prestito.Collocazione
GROUP BY
    ISBN