SET SERVEROUTPUT ON; 

SELECT bytes/(1024*1024) AS utilis�, max_bytes/(1024*1024) AS maximum
FROM dba_ts_quotas
WHERE username = USER;

PURGE RECYCLEBIN;

SELECT * FROM NOTE_AUTO_S204;

BEGIN
   FOR obj IN (
      SELECT object_name, object_type
      FROM user_objects
      WHERE object_type IN ('TABLE', 'VIEW')
   ) LOOP
      -- Droits pour AnalyseJV (lecture sauf LOG)
      IF obj.object_name <> 'LOG' THEN
         IF obj.object_type IN ('TABLE', 'VIEW') THEN
            EXECUTE IMMEDIATE 'GRANT SELECT ON ' || obj.object_name || ' TO AnalyseJV';
         END IF;
      END IF;

      -- Droits pour GestionJV
      IF obj.object_type IN ('TABLE', 'VIEW') THEN
         IF obj.object_name = 'LOG' THEN
            EXECUTE IMMEDIATE 'GRANT SELECT ON ' || obj.object_name || ' TO GestionJV';
         ELSE
            EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || obj.object_name || ' TO GestionJV';
         END IF;
      END IF;
   END LOOP;

   -- Fonctions/proc�dures pour AnalyseJV (lecture uniquement)
   FOR obj IN (
      SELECT object_name
      FROM user_procedures
      WHERE object_type IN ('FUNCTION', 'PROCEDURE')
        AND object_name NOT IN ('PROC1_MODIF', 'PROC2_MODIF') -- � adapter
   ) LOOP
      EXECUTE IMMEDIATE 'GRANT EXECUTE ON ' || obj.object_name || ' TO AnalyseJV';
   END LOOP;

   -- Fonctions/proc�dures pour GestionJV (acc�s total)
   FOR obj IN (
      SELECT object_name
      FROM user_procedures
      WHERE object_type IN ('FUNCTION', 'PROCEDURE')
   ) LOOP
      EXECUTE IMMEDIATE 'GRANT ALL ON ' || obj.object_name || ' TO GestionJV';
   END LOOP;
END;
/

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
CREATE OR REPLACE VIEW SORTIES_RECENTES AS
SELECT J.idJeu, J.titreJeu, DS.datesortie, LISTAGG(DISTINCT P.nomplateforme, ', ') WITHIN GROUP (ORDER BY P.nomplateforme) AS plateforme
FROM jeu J
    JOIN datesortie DS ON ds.idJeu = j.idJeu
    JOIN plateforme P ON P.idplateforme = DS.idplateforme
WHERE DS.datesortie <= SYSDATE
GROUP BY J.idJeu, J.titreJeu, DS.datesortie
ORDER BY DS.datesortie DESC, J.titrejeu ASC;

SELECT * FROM SORTIES_RECENTES;

// Fonction FICHE_DETAILLEE
CREATE OR REPLACE FUNCTION FICHE_DETAILLEE(p_id_jeu IN JEU.IdJeu%TYPE) RETURN CLOB
IS
    v_json CLOB;
    v_count NUMBER;
BEGIN
    
    SELECT COUNT(*)
    INTO v_count
    FROM JEU J
    WHERE J.idJeu = p_id_jeu;
    
    if v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Jeu inexistant');
    END IF;

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
        -- Retourner un message JSON disant que le film n'existe pas
        RETURN '{"error":"Film non trouvé pour l\'ID ' || p_film_id || '"}';
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
               'id'       VALUE t.id,
               'titre'    VALUE t.titre,
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
        (0.5*P1.visits + 0.25*P1.played + 0.15*P1.playing + 0.10*P1."Want to Play") AS popscore,
        RANK() OVER (
          ORDER BY (0.5*P1.visits + 0.25*P1.played + 0.15*P1.playing + 0.10*P1."Want to Play") DESC
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
CREATE OR REPLACE PROCEDURE AJOUTER_DATE_SORTIE (p_id_date_sortie IN DATESORTIE.idDateSortie%TYPE)
BEGIN

END;
/

// Procédure AJOUTER_MODE_MULTIJOUEUR
CREATE OR REPLACE PROCEDURE AJOUTER_MODE_MULTIJOUEUR (p_id_mode_multijoueur IN MODEMULTIJOUEUR.idModeMultijoueur%TYPE)
BEGIN

END;
/

