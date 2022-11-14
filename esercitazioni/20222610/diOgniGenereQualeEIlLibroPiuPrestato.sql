SELECT Collocazione, Genere
FROM (
        PRESTITI P1
        LEFT JOIN ( (
                COPIA C1
                LEFT JOIN DatiLibro D1 ON C1.ISBN = D1.ISBN
            ) AS X1
        ) ON P1.Collocazione = X1.Collocazione
    ) AS Y1
GROUP BY Collocazione, Genere
HAVING COUNT(*) >= ALL (
        SELECT COUNT(*)
        FROM (
                PRESTITI P2
                LEFT JOIN ( (
                        COPIA C2
                        LEFT JOIN DatiLibro D2 ON C2.ISBN = D2.ISBN
                    ) AS X2
                ) ON P2.Collocazione = X2.Collocazione
            ) AS Y2
        GROUP BY Collocazione
        HAVING
            Y1.Genere = Y2.Genere
    )