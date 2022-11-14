SELECT
    ISBN,
    count (CodUtente)
FROM
    Prestito
    RIGHT JOIN Copia -- non cambia niente, come prima ma al contrario con le tabelle invertite
    ON Copia.Collocazione = Prestito.Collocazione
    JOIN DatiLibro D ON D.ISBN = Copia.ISBN
GROUP BY
    ISBN
SELECT
    Titolo,
    (
        SELECT
            *
        FROM
            Prestito
            JOIN Copia ON Copia.Collocazione = Prestito.Collocazione
            JOIN DatiLibro ON DatiLibro.ISBN = Copia.ISBN
        WHERE
            Titolo = D.Titolo
    )
FROM
    DatiLibro D