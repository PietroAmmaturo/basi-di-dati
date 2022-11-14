SELECT
    avg(DataResa - DataPrestito)
FROM
    Prestito
WHERE
    DataResa IS NOT NULL