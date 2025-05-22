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
    SELECT j.idjeu, j.titrejeu, MIN(DS.datesortie) AS date_premiere_sortie, COALESCE(j.statutjeu, 'Publi�') AS statut,

    -- Liste des compagnies d�veloppeuses
    LISTAGG(DISTINCT c.nomcompagnie, ', ') WITHIN GROUP (ORDER BY c.nomcompagnie) AS compagnies,

    -- Liste des genres
    LISTAGG(DISTINCT g.nomgenre, ', ') WITHIN GROUP (ORDER BY g.nomgenre) AS genres,

    -- Liste des plateformes
    LISTAGG(DISTINCT p.nomplateforme, ', ') WITHIN GROUP (ORDER BY p.nomplateforme) AS plateformes,

    -- Score utilisateur moyen arrondi � 2 d�cimales
    ROUND(AVG(DISTINCT J.scorejeu), 2) AS score_utilisateur,

    -- Score critique moyen arrondi � 2 d�cimales
    ROUND(AVG(DISTINCT J.scoreigdb), 2) AS score_critique

FROM
    jeu J
    LEFT JOIN datesortie DS ON J.idjeu = DS.idjeu
    LEFT JOIN compagniejeu CJ ON J.idjeu = CJ.idjeu
    LEFT JOIN compagnie C ON CJ.idcompagnie = C.idcompagnie
    LEFT JOIN genrejeu GJ ON J.idjeu = GJ.idjeu
    LEFT JOIN genre G ON GJ.idgenre = G.idgenre
    LEFT JOIN plateforme P ON DS.idplateforme = P.idplateforme

GROUP BY
    j.idjeu,
    j.titrejeu,
    COALESCE(j.statutjeu, 'Publi�');

SELECT * FROM FICHE_JEU;


// Vue SORTIES_RECENTES


// Fonction FICHE_DETAILLEE
CREATE OR REPLACE FUNCTION FICHE_DETAILLEE(p_id_jeu IN JEU.IdJeu%TYPE) RETURN CLOB
IS
    v_json CLOB;
    v_count NUMBER;
BEGIN

    SELECT JSON_OBJECT(
        'titre' VALUE J.TitreJeu,
        'résumé' VALUE J.ResumeJeu,
        
        'mode(s) de jeu' VALUE (
            SELECT JSON_ARRAYAGG(m.NomModalite ORDER BY m.IdModalite)
            FROM MODALITE M
            JOIN MODALITEJEU MJ ON MJ.idModalite = M.idModalite
            JOIN MODEMULTIJOUEUR MM ON MM.idJeu = MJ.idJeu
            JOIN JEU J ON J.IdJeu = p_id_jeu
        ),
        
        'développeur(s)' VALUE (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE C.IdCompagnie,
                    'nom' VALUE C.NomCompagnie
                ) ORDER BY C.NomCompagnie
            )
            FROM COMPAGNIE C
            JOIN COMPAGNIEJeu CJ ON C.IdCompagnie = CJ.idCompagnie
            WHERE CJ.IdJeu = p_id_jeu
        ),
        
        'publieur(s)' VALUE (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE C.IdCompagnie,
                    'nom' VALUE C.NomCompagnie
                ) ORDER BY C.NomCompagnie
            )
            FROM COMPAGNIE C
            JOIN COMPAGNIEJeu CJ ON C.IdCompagnie = CJ.idCompagnie
            WHERE CJ.IdJeu = p_id_jeu
        ),
        
        'plateforme(s)' VALUE (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'nom' VALUE P.NomPlateforme,
                    'date sortie' VALUE DS.DateSortie,
                    'statut' VALUE NVL(DS.StatutSortie, 'Full release')
                ) ORDER BY P.NomPlateforme, DS.DateSortie
            )
            FROM PLATEFORME P
            JOIN DATESORTIE DS ON DS.idPlateforme = P.idPlateforme
            WHERE DS.IdJeu = p_id_jeu
        ),

        'score' VALUE J.ScoreJeu,
        'nb votes' VALUE J.NombreNotesJeu,
        'score critiques' VALUE J.ScoreIGDB,
        'nb votes critiques' VALUE J.NombreNotesIGDBJeu

    ) INTO v_json
    FROM JEU J
    WHERE J.IdJeu = p_id_jeu;

    RETURN v_json;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '{"erreur":"Jeu innexistant"}';
    WHEN OTHERS THEN
        RETURN '{"erreur":"Erreur interne"}';
END;
/

SELECT FICHE_DETAILLEE(127842678642) AS resultat_json FROM DUAL;

// Fontcion MEILLEURS_JEUX
CREATE OR REPLACE FUNCTION MEILLEURS_JEUX(id_plateforme IN NUMBER)
  RETURN CLOB
IS
  v_json  CLOB;
  v_count NUMBER;
BEGIN
  -- Vérifier que la plateforme existe
  SELECT COUNT(*) INTO v_count
    FROM PLATEFORME
   WHERE idPlateforme = id_plateforme;
  IF v_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Plateforme inexistante');
  END IF;

  -- Construire le JSON des meilleurs jeux
  SELECT JSON_OBJECT(
           'jeux' VALUE JSON_ARRAYAGG(
             JSON_OBJECT(
               'id'       VALUE t.idJeu,
               'titre'    VALUE t.titreJeu,
               'popscore' VALUE t.popscore,
               'rang'     VALUE t.rang
             )
           ) RETURNING CLOB
         )
    INTO v_json
    FROM (
      SELECT 
        J.idJeu,
        J.titreJeu,
        (0.5 * SUM(CASE WHEN P1.mesurePopularite = 'visits' THEN P1.valeurpopularite ELSE 0 END) +
         0.25 * SUM(CASE WHEN P1.mesurePopularite = 'played' THEN P1.valeurpopularite ELSE 0 END) +
         0.15 * SUM(CASE WHEN P1.mesurePopularite = 'playing' THEN P1.valeurpopularite ELSE 0 END) +
         0.10 * SUM(CASE WHEN P1.mesurePopularite = 'Want to Play' THEN P1.valeurpopularite ELSE 0 END)
        ) AS popscore,
    
      RANK() OVER (
        ORDER BY (
          0.5 * SUM(CASE WHEN P1.mesurePopularite = 'visits' THEN P1.valeurpopularite ELSE 0 END) +
          0.25 * SUM(CASE WHEN P1.mesurePopularite = 'played' THEN P1.valeurpopularite ELSE 0 END) +
          0.15 * SUM(CASE WHEN P1.mesurePopularite = 'playing' THEN P1.valeurpopularite ELSE 0 END) +
          0.10 * SUM(CASE WHEN P1.mesurePopularite = 'Want to Play' THEN P1.valeurpopularite ELSE 0 END)
        ) DESC
    ) AS rang

FROM JEU J
JOIN MODEMULTIJOUEUR MM ON MM.idJeu = J.idJeu
JOIN POPULARITE P1 ON P1.idJeu = J.idJeu
WHERE MM.idPlateforme = id_plateforme
    ) t
   WHERE t.rang <= 100;

  RETURN v_json;
END;
/

// Procédure AJOUTER_DATE_SORTIE
CREATE OR REPLACE PROCEDURE AJOUTER_DATE_SORTIE(
    p_idJeu         IN NUMBER,
    p_idPlateforme  IN NUMBER,
    p_dateSortie    IN DATE,
    p_regionSortie  IN VARCHAR2,
    p_statut        IN VARCHAR2
) IS
    v_count NUMBER;
BEGIN
    -- Vérification 1 : Jeu inexistant
    SELECT COUNT(*) INTO v_count FROM JEU WHERE idJeu = p_idJeu;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Jeu inexistant');
    END IF;

    -- Vérification 2 : Plateforme inexistante
    SELECT COUNT(*) INTO v_count FROM PLATEFORME WHERE idPlateforme = p_idPlateforme;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Plateforme inexistante');
    END IF;

    -- Vérification 3 : Région inconnue
    SELECT COUNT(*) INTO v_count FROM REGION WHERE nomRegion = p_regionSortie;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'R�gion inconnue');
    END IF;

    -- Vérification 4 : Doublon de sortie (même jeu + plateforme + région)
    SELECT COUNT(*) INTO v_count
    FROM DATESORTIE
    WHERE idJeu = p_idJeu AND idPlateforme = p_idPlateforme AND regionSortie = p_regionSortie;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Sortie d�j� enregistr�e');
    END IF;

    -- Insertion de la nouvelle sortie
    INSERT INTO DATESORTIE (idJeu, idPlateforme, dateSortie, regionSortie, statutSortie)
    VALUES (p_idJeu, p_idPlateforme, p_dateSortie, p_regionSortie, p_statut);
    
END;
/


// Procédure AJOUTER_MODE_MULTIJOUEUR
CREATE OR REPLACE PROCEDURE AJOUTER_MODE_MULTIJOUEUR (p_id_mode_multijoueur IN MODEMULTIJOUEUR.idModeMultijoueur%TYPE)
BEGIN

END;
/