SELECT
    CodUtente,
    count(*)
FROM
    Prestito
GROUP BY
    CodUtente