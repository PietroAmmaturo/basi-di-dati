SELECT ISBN, AnnoPub
FROM DATILIBRO D
WHERE
    --se volessi l'ISBN del (o dei) libri gialli più vecchi, mi basta cercare tutti quelli pubblicati nella data più vecchia
    D.AnnoPub = (
        SELECT min(AnnoPub)
        FROM (
                SELECT
                    AnnoPub
                FROM
                    DATILIBRO D
                WHERE (
                        -- controllo che si tratti di un libro giallo appartenente a una casa editrice di cui a biblioteca ha almeno 100 diversi libri
                        D.ISBN IN (
                            SELECT
                                *
                            FROM
                                LibriGialliAppartenentiACaseEditriciDiCuiLaBibliotecaHaAlmeno100DiversiLibri (Casa, ISBN) = ()
                        )
                    )
            )
    )
CREATE VIEW
    CaseEditriciDiCuiLaBibliotecaHaAlmeno100DiversiLibriGialli (Casa) = (
        SELECT CasaEd
        FROM DATILIBRO NATURAL JOIN COPIA AS X-- verifico di avere una copia del libro presente in datilibro
        WHERE X.Genere = "Giallo"
        GROUP BY CasaEd
        HAVING
            COUNT(DISTINCT ISBN) >= 100 -- controllo che il numero di libri diversi sia almeno 100
    )
CREATE VIEW
    LibriGialliAppartenentiACaseEditriciDiCuiLaBibliotecaHaAlmeno100DiversiLibri (Casa, ISBN) = (
        SELECT ISBN
        FROM DATILIBRO D
        WHERE ( (
                    -- controllo che si tratti di un libro appartenente a una casa editrice di cui a biblioteca ha almeno 100 diversi libri
                    D.CasaEd IN (
                        SELECT
                            *
                        FROM
                            CaseEditriciDiCuiLaBibliotecaHaAlmeno100DiversiLibri
                    )
                )
                AND (D.Genere = "Giallo") -- controllo che il genere sia giallo
            )
    )