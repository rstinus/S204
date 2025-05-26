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
    SELECT j.idjeu, j.titrejeu, MIN(DS.datesortie) AS date_premiere_sortie, COALESCE(j.statutjeu, 'Publié') AS statut,

    -- Liste des compagnies d�veloppeuses
    LISTAGG(DISTINCT CASE WHEN CJ.estDeveloppeur = 1 THEN c.nomcompagnie END, ', ') WITHIN GROUP (ORDER BY c.nomcompagnie) AS compagnies,

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
    j.idjeu, j.titrejeu, j.statutjeu
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
// Vue SORTIES_RECENTES


// Fonction FICHE_DETAILLEE
CREATE OR REPLACE FUNCTION FICHE_DETAILLEE(p_id_jeu IN JEU.IdJeu%TYPE) RETURN CLOB
IS
    v_json CLOB;
    v_count NUMBER;
BEGIN
    -- Vérifie si le jeu existe
    SELECT COUNT(*) INTO v_count FROM JEU WHERE idJeu = p_id_jeu;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Jeu inexistant');
    END IF;

    -- Génère le JSON
    SELECT JSON_OBJECT(
        'titre' VALUE J.TitreJeu,
        'résumé' VALUE J.ResumeJeu,

        'mode(s) de jeu' VALUE (
            SELECT JSON_ARRAYAGG(m.NomModalite RETURNING CLOB) 
            FROM MODALITE M
            JOIN MODALITEJEU MJ ON MJ.idModalite = M.idModalite
            WHERE MJ.idJeu = J.IdJeu
        ),

        'développeur(s)' VALUE (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE C.IdCompagnie,
                    'nom' VALUE C.NomCompagnie
                RETURNING CLOB)
                ORDER BY C.NomCompagnie
            RETURNING CLOB)
            FROM COMPAGNIE C
            JOIN COMPAGNIEJeu CJ ON C.IdCompagnie = CJ.idCompagnie
            WHERE CJ.IdJeu = J.IdJeu AND CJ.estDeveloppeur = 1
        ),

        'publieur(s)' VALUE (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE C.IdCompagnie,
                    'nom' VALUE C.NomCompagnie
                RETURNING CLOB)
                ORDER BY C.NomCompagnie
            RETURNING CLOB)
            FROM COMPAGNIE C
            JOIN COMPAGNIEJeu CJ ON C.IdCompagnie = CJ.idCompagnie
            WHERE CJ.IdJeu = J.IdJeu AND CJ.estPublieur = 1
        ),

        'plateforme(s)' VALUE (
            SELECT JSON_ARRAYAGG(
                JSON_OBJECT(
                    'nom' VALUE P.NomPlateforme,
                    'date sortie' VALUE DS.DateSortie,
                    'statut' VALUE NVL(DS.StatutSortie, 'Full release')
                RETURNING CLOB)
                ORDER BY P.NomPlateforme, DS.DateSortie
            RETURNING CLOB)
            FROM PLATEFORME P
            JOIN DATESORTIE DS ON DS.idPlateforme = P.idPlateforme
            WHERE DS.IdJeu = J.IdJeu
        ),

        'score' VALUE J.ScoreJeu,
        'nb votes' VALUE J.NombreNotesJeu,
        'score critiques' VALUE J.ScoreAgregeJeu,
        'nb votes critiques' VALUE J.NombreNotesAgregeesJeu

        RETURNING CLOB
    ) INTO v_json
    FROM JEU J
    WHERE J.IdJeu = p_id_jeu;

    RETURN v_json;

END;
/

SELECT FICHE_DETAILLEE(434) AS resultat_json FROM DUAL;
SELECT FICHE_DETAILLEE(45476) AS resultat_json FROM DUAL;
SELECT FICHE_DETAILLEE(24944) AS resultat_json FROM DUAL;

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
             )RETURNING CLOB
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
JOIN DATESORTIE DS ON DS.idJeu = J.idJeu
JOIN PLATEFORME P ON P.idPlateforme = DS.idPlateforme
JOIN POPULARITE P1 ON P1.idJeu = J.idJeu
WHERE P.idPlateforme = id_plateforme
GROUP BY J.idJeu, J.titreJeu
    ) t
   WHERE t.rang <= 100;

  RETURN v_json;
END;
/

SELECT MEILLEURS_JEUX(33) AS resultat_json FROM DUAL;
SELECT MEILLEURS_JEUX(111) AS resultat_json FROM DUAL;
SELECT MEILLEURS_JEUX(3) AS resultat_json FROM DUAL;

EXECUTE ajouter_date_sortie(129113, 82, '12/10/24', 'europe', 'Full Release');

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
        RAISE_APPLICATION_ERROR(-20003, 'Region inconnue');
    END IF;

    -- Vérification 4 : Doublon de sortie (même jeu + plateforme + région)
    SELECT COUNT(*) INTO v_count FROM DATESORTIE WHERE idJeu = p_idJeu AND idPlateforme = p_idPlateforme AND regionSortie = p_regionSortie;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Sortie deja enregistree');
    END IF;

    -- Insertion de la nouvelle sortie
    INSERT INTO DATESORTIE (idJeu, idPlateforme, dateSortie, regionSortie, statutSortie)
    VALUES (p_idJeu, p_idPlateforme, p_dateSortie, p_regionSortie, p_statut);
    
END;
/


// Procédure AJOUTER_MODE_MULTIJOUEUR
CREATE OR REPLACE PROCEDURE AJOUTER_MODE_MULTIJOUEUR (
    p_id_jeu IN NUMBER,
    p_id_plateforme IN NUMBER,
    p_drop_in IN NUMBER,
    p_mode_coop_campagne IN NUMBER,
    p_mode_coop_lan IN NUMBER,
    p_mode_coop_offline IN NUMBER,
    p_mode_coop_online IN NUMBER,
    p_mode_split_screen IN NUMBER,
    p_nb_joueurs_max_coop_offline IN NUMBER,
    p_nb_joueurs_max_offline IN NUMBER,
    p_nb_joueurs_max_coop_online IN NUMBER,
    p_nb_joueurs_max_online IN NUMBER
    
) IS

    p_count_jeu NUMBER;
    p_count_plateforme NUMBER;
    p_count NUMBER;

BEGIN
    
    SELECT COUNT(*) INTO p_count_jeu FROM JEU Where idJeu = p_id_jeu;
    IF p_count_jeu = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Jeu inexistant');
    END IF;
    
    SELECT COUNT(*) INTO p_count_plateforme FROM PLATEFORME Where idPlateforme = p_id_plateforme;
    IF p_count_plateforme = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Plateforme inexistante');
    END IF;
    
    SELECT 1 INTO p_count FROM MODEMULTIJOUEUR WHERE idJeu = p_id_jeu AND idPlateforme = p_id_plateforme;
        RAISE_APPLICATION_ERROR(-20005, 'Mode Multijoueur deja enregistre');

    IF (p_mode_coop_online = 1 AND p_nb_joueurs_max_coop_online = 0) OR (p_mode_coop_online = 0 AND p_nb_joueurs_max_coop_online > 0) THEN
        RAISE_APPLICATION_ERROR(-20006, 'Données incohérentes : ModeCoopOnline');
    END IF;

    IF (p_mode_coop_offline = 1 AND p_nb_joueurs_max_coop_offline = 0) OR (p_mode_coop_offline = 0 AND p_nb_joueurs_max_coop_offline > 0) THEN
        RAISE_APPLICATION_ERROR(-20006, 'Données incohérentes : ModeCoopOffline');
    END IF;

    INSERT INTO modemultijoueur (
        idjeu, idplateforme, DropIn, ModeCoopCampagne, ModeCoopLAN,
        ModeCoopOffline, ModeCoopOnline, ModeSplitScreen,
        NbJoueursMaxCoopOffline, NbJoueursMaxOffline,
        NbJoueursMaxCoopOnline, NbJoueursMaxOnline
    ) VALUES (
        p_id_jeu, p_id_plateforme, p_drop_in, p_mode_coop_campagne, p_mode_coop_lan,
        p_mode_coop_offline, p_mode_coop_online, p_mode_split_screen,
        p_nb_joueurs_max_coop_offline, p_nb_joueurs_max_offline,
        p_nb_joueurs_max_coop_online, p_nb_joueurs_max_online
    );
END;
/