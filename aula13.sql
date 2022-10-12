DROP DATABASE IF EXISTS transaction_rollback;

CREATE DATABASE transaction_rollback;

USE transaction_rollback;

CREATE TABLE musics(
    id_music INTEGER PRIMARY KEY AUTO_INCREMENT,
    good TINYINT nOT NULL,
    name_of_music VARCHAR(255),
    band VARCHAR(255),
    created_at DATETIME DEFAULT NOW()
);

INSERT INTO musics
    (name_of_music, band, good)
VALUES
    ('Northing Else Matters', 'Metalica', 1),
    ('Enter Sandman',         'Metalica', 1),
    ('My Frinend of Misery',  'Metalica', 1),
    ('Deutshchland',          'Rammstein', 1),
    ('Rosenrot',              'Rammstein', 1),
    ('Ohne dich',             'Rammstein', 1),
    ('La Loto',               'Anitta', 1);


/*SET autocommit=1;ele comita salva a transacao*/

SELECT "BEFORE DELETE ROW OF musics TABLE " AS 'LOG';

SELECT * fROM musics;

SET autocommit=0;/*em bd e quando efetiva uma transação*/

/*START TRANSACTION;
    DELETE FROM musics WHERE name_of_music = 'La Loto';

SELECT "AFTER DELETE ROW OF musics TABLE" AS 'LOG';

COMMIT;

SELECT "COMMIT EXECUTED" AS 'LOG';

SELECT * fROM musics;

ROLLBACK;

SELECT "ROLLBACK EXECUTED" AS 'LOG';

SELECT * FROM musics;

SET autocommit=1;*/


START TRANSACTION;
    ALTER TABLE musics ADD good TINYINT;

    UPDATE
        musics
    SET
        good=1
    WHERE
        band IN ('Metalica', 'Rammstein');

    UPDATE
        musics
    SET
        good=0
    WHERE
        band = 'Anitta';
    


SELECT "AFTER DELETE ROW OF musics TABLE" AS 'LOG';

SELECT * FROM musics;

ROLLBACK;

SELECT * FROM musics;
