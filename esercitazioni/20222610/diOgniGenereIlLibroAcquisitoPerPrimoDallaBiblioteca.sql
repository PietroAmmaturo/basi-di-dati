/*assumendo di non avere una sola copia per ogni libro (ci sono isbn duplicati in COPIA)*/

SELECT
    Genere,
    DataAcquisizione,
    Titolo,
    Collocazione
FROM DATILIBRO D
    JOIN COPIA C ON D.ISBN = C.ISBN
WHERE (C.DataAcquisizione, D.Genere) = (
        SELECT
            MIN(C.DataAcquisizione)
        FROM DATILIBRO D2
            LEFT JOIN COPIA C2 ON D2.ISBN = C2.ISBN --serve il left join, altrimenti perderei date di acquisizione (se avessi acquisito più copie dello stesso libro)
        GROUP BY
            Genere
    ) -- efe
CREATE VIEW
    PrimoDiOgniGen (AcquisitionDate, Genre) = (
        SELECT
            MIN(DataAcquisizione),
            Genere
        FROM DATILIBRO D
            LEFT JOIN COPIA C ON D.ISBN = C.ISBN --serve il left join, altrimenti perderei date di acquisizione (se avessi acquisito più copie dello stesso libro)
        GROUP BY Genere
    )
SELECT
    Genere,
    DataAcquisizione,
    Titolo,
    Collocazione
FROM PrimoDiOgniGen P
    JOIN (
        COPIA C
        RIGHT JOIN DATILIBRO D ON C.ISBN = D.ISBN AS X --serve il right join, altrimenti perderei date di acquisizione (se avessi acquisito più copie dello stesso libro)
    ) ON (X.DataAcquisizione, X.Genere) = (Genre, AcquisitionDate)
    /*----------------------------------------------------------------------------------*/
    /*assumendo di avere una sola copia per ogni libro (non ci sono isbn duplicati in COPIA)*/
    /*----------------------------------------------------------------------------------*/
SELECT
    Genere,
    DataAcquisizione,
    Titolo,
    Collocazione
FROM DATILIBRO D
    JOIN COPIA C ON D.ISBN = C.ISBN
WHERE (C.DataAcquisizione, D.Genere) = (
        SELECT
            MIN(C.DataAcquisizione)
        FROM DATILIBRO D2
            JOIN COPIA C2 ON D2.ISBN = C2.ISBN -- assumo che ogni isbn abbia solo una copia e quindi una sola data di acquisizione
        GROUP BY
            Genere
    )
    /*----------------------------------------------------------------------------------*/
    /*creo una view*/
    /*----------------------------------------------------------------------------------*/
CREATE VIEW
    PrimoDiOgniGen (AcquisitionDate, Genre) = (
        SELECT
            MIN(DataAcquisizione),
            Genere
        FROM DATILIBRO D
            JOIN COPIA C ON D.ISBN = C.ISBN -- assumo che ogni isbn abbia solo una copia e quindi una sola data di acquisizione
        GROUP BY
            Genere
    )
    /*----------------------------------------------------------------------------------*/
    /*uso la VIEW con JOIN*/
    /*----------------------------------------------------------------------------------*/
SELECT
    Genere,
    DataAcquisizione,
    Titolo,
    Collocazione
FROM PrimoDiOgniGen P
    JOIN (
        COPIA C
        JOIN DATILIBRO D ON C.ISBN = D.ISBN AS X -- assumo che ogni isbn abbia solo una copia e quindi una sola data di acquisizione
    ) ON (X.DataAcquisizione, X.Genere) = (Genre, AcquisitionDate)
    /*----------------------------------------------------------------------------------*/
    /*uso la VIEW con l'operatore IN*/
    /*----------------------------------------------------------------------------------*/
SELECT
    Genere,
    DataAcquisizione,
    Titolo,
    Collocazione
FROM DATILIBRO D
    JOIN COPIA C ON D.ISBN = C.ISBN AS X
WHERE (X.Genere, X.DataAcquisizione) IN (
        SELECT *
        FROM PrimoDiOgniGen
    )