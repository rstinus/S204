SET SERVEROUTPUT ON; 

SELECT bytes/(1024*1024) AS utilis�, max_bytes/(1024*1024) AS maximum
FROM dba_ts_quotas
WHERE username = USER;

PURGE RECYCLEBIN;

SELECT * FROM NOTE_AUTO_S204;

SELECT COUNT(CASE WHEN commentaire = 'OK' THEN 1 END) || '/' || COUNT(*) AS resultat
FROM note_auto_s204;

SELECT TO_CHAR(SUM(note)) || '/20' AS note
FROM NOTE_AUTO_S204;

// Vue FICHE_JEU
CREATE OR REPLACE VIEW FICHE_JEU AS
    SELECT j.IDJEU AS identifiant,
 j.TITREJEU AS titre,
 MIN(ds.DATESORTIE) AS premiere_date_sortie,
 COALESCE(j.STATUTJEU, 'Publié') AS statut,

    -- Liste des compagnies d�veloppeuses
    LISTAGG(DISTINCT CASE WHEN CJ.estDeveloppeur = 1 THEN c.nomcompagnie END, ', ') WITHIN GROUP (ORDER BY c.nomcompagnie) AS compagnies,

    -- Liste des genres
    LISTAGG(DISTINCT g.nomgenre, ', ') WITHIN GROUP (ORDER BY g.nomgenre) AS genres,

    -- Liste des plateformes
    LISTAGG(DISTINCT p.nomplateforme, ', ') WITHIN GROUP (ORDER BY p.nomplateforme) AS plateformes,

    ROUND(CAST(j.SCOREIGDB AS NUMBER) / 10, 2) AS score_utilisateur,
    ROUND(CAST(j.SCOREAGREGEJEU AS NUMBER) / 10, 2) AS score_critique

FROM
    jeu J
    LEFT JOIN datesortie DS ON J.idjeu = DS.idjeu
    LEFT JOIN compagniejeu CJ ON J.idjeu = CJ.idjeu
    LEFT JOIN compagnie C ON CJ.idcompagnie = C.idcompagnie
    LEFT JOIN genrejeu GJ ON J.idjeu = GJ.idjeu
    LEFT JOIN genre G ON GJ.idgenre = G.idgenre
    LEFT JOIN plateforme P ON DS.idplateforme = P.idplateforme

GROUP BY
    j.idjeu, j.titrejeu, j.statutjeu, j.SCOREIGDB, j.scoreagregeJeu
    ORDER BY
        j.idJeu;

SELECT * FROM FICHE_JEU;
/*
CREATE OR REPLACE VIEW FICHE_JEU AS
SELECT
 j.IDJEU AS identifiant,
 j.TITREJEU AS titre,
 MIN(ds.DATESORTIE) AS premiere_date_sortie,
 COALESCE(j.STATUTJEU, 'Publié') AS statut,

 LISTAGG(DISTINCT CASE
 WHEN cj.ESTDEVELOPPEUR = 1 THEN c.NOMCOMPAGNIE END, ', ')
 WITHIN GROUP (ORDER BY c.NOMCOMPAGNIE) AS compagnies,

 LISTAGG(DISTINCT g.NOMGENRE, ', ')
 WITHIN GROUP (ORDER BY g.NOMGENRE) AS genres,

 LISTAGG(DISTINCT p.NOMPLATEFORME, ', ')
 WITHIN GROUP (ORDER BY p.NOMPLATEFORME) AS plateformes,

 ROUND(CAST(j.SCOREIGDB AS NUMBER) / 10, 2) AS score_utilisateur,
 ROUND(CAST(j.SCOREAGREGEJEU AS NUMBER) / 10, 2) AS score_critique
FROM
 JEU j
 LEFT JOIN DATESORTIE ds ON j.IDJEU = ds.IDJEU
 LEFT JOIN COMPAGNIEJEU cj ON j.IDJEU = cj.IDJEU AND cj.ESTDEVELOPPEUR =
1
 LEFT JOIN COMPAGNIE c ON cj.IDCOMPAGNIE = c.IDCOMPAGNIE
 LEFT JOIN GENREJEU gj ON j.IDJEU = gj.IDJEU
 LEFT JOIN GENRE g ON gj.IDGENRE = g.IDGENRE
 LEFT JOIN PLATEFORME p ON ds.IDPLATEFORME = p.IDPLATEFORME
GROUP BY
 j.IDJEU, j.TITREJEU, j.STATUTJEU, j.SCOREIGDB, j.SCOREAGREGEJEU
ORDER BY
 j.IDJEU;
*/