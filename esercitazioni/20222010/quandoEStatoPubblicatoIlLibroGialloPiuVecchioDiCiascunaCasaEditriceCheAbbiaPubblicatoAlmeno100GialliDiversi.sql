SELECT
    casaEd,
    min(AnnoPub)
FROM
    DatiLibro
WHERE
    Genere = 'Giallo'
GROUP BY
    CasaEd
HAVING
    count (*) >= 100