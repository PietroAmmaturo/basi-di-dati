-- contare il numero di DataPrestito per ogni collocazione

-- trovare il massimo

-- ricontare il numero di DataPrestito e porlo uguale al massimo

SELECT
    Collocazione,
    NumeroDiPrestiti
FROM
    NumeroDiPrestitiPerOgniCollocazione X
WHERE X.NumeroDiPrestiti = (
        SELECT
            MAX(Y.NumeroDiPrestiti)
        FROM
            NumeroDiPrestitiPerOgniCollocazione AS Y
    )
CREATE VIEW
    NumeroDiPrestitiPerOgniCollocazione (
        Collocazione,
        NumeroDiPrestiti
    ) = ( (
            -- Conto i prestiti di ogni copia (che ha una collocazione) che è presente nella tabella prestiti
            SELECT
                Collocazione,
                count(*)
            FROM PRESTITO
            GROUP BY
                Collocazione
        )
        UNION (
            -- le copie non presenti nella tabella prestiti non sono mai state prestate! (pongo NumeroDiPrestiti a 0)
            SELECT
                Collocazione,
                0
            FROM COPIA C
            WHERE NOT EXISTS (
                    SELECT *
                    FROM
                        PRESTITO P
                    WHERE
                        C.Collocazione = P.Collocazione
                )
        )
    )
SELECT
    -- questa versione trascura le copie che non sono mai state prestate (ritorna vuoto in quel caso)
    Collocazione,
    COUNT(*)
FROM Prestito
GROUP BY Collocazione
HAVING COUNT(*) >= ALL (
        SELECT COUNT(*)
        FROM Prestito
        GROUP BY
            Collocazione
    )
SELECT
    -- questa versione trascura le copie che non sono mai state prestate (ritorna vuoto in quel caso)
    -- e necessita di un massimo assoluto (se vi sono più copie prestate lo stesso numero di volte ritorna vuoto)
    Collocazione,
    COUNT(*)
FROM Prestito P1
GROUP BY Collocazione
HAVING COUNT(*) > ALL (
        SELECT COUNT(*)
        FROM Prestito AS P2
        WHERE
            P1.Collocazione <> P2.Collocazione
        GROUP BY Collocazione
    )