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