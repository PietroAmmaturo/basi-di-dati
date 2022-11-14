SELECT
    min(DataAcquisizione),
    Titolo
FROM
    Copia C
    JOIN DatiLibro D ON C.ISBN = D.ISBN;