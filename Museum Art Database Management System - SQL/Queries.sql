/* 1) Show all tables and explain how they are related to one another (keys, triggers, etc.) */
SELECT
  TABLE_NAME, COLUMN_NAME, DATA_TYPE, COLUMN_KEY
FROM
  INFORMATION_SCHEMA.COLUMNS
WHERE
  TABLE_SCHEMA IN ('ART_MUSEUM');


/* 2) A basic retrieval query */
SELECT * FROM ART_OBJECT
WHERE ID_Num = 'P_014';


/* 3) A retrieval query with ordered results */
SELECT * FROM PAINTING
ORDER BY Style ASC;


/* 4) A nested retrieval query */
SELECT *
FROM ART_OBJECT
WHERE ID_Num IN (
SELECT ID_Num
FROM PERMANENT_COLLECTION) ;


/* 5) A retrieval query using joined tables */
SELECT ID_Num, Title, Artist
FROM (( ARTIST JOIN ART_OBJECT ON Name = Artist) );


/* 6) An update operation with any necessary triggers */
UPDATE PERMANENT_COLLECTION
SET Status="On Display"
WHERE ID_Num = 'A_004';


/* 7) A deletion operation with any necessary triggers */
DELETE FROM PAINTING where ID_Num = 'E_008';