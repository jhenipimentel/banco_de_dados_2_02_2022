DROP DATABASE IF EXISTS Trabalho_1;
CREATE DATABASE IF NOT EXISTS Trabalho_1 CHARACTER SET utf8mb4;

USE Trabalho_1;

CREATE TABLE jhenifer(
    id_jhenifer INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    rg          VARCHAR(255)
   
);

CREATE TABLE pimentel(
    id_pimentel INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cpf          VARCHAR(255),
    id_jhenifer INTEGER,
    FOREIGN KEY (id_jhenifer) REFERENCES jhenifer(id_jhenifer)
   
);

INSERT INTO jhenifer (rg) VALUES
    ('2457574575'),
    ('5758788268'),
    ('8256588651'),
    ('4557772255');

INSERT INTO pimentel (cpf, id_jhenifer) VALUES
    ('58755442275', 1),
    ('45524588442', 2),
    ('25522366422', 3),
    ('55002556055', 4);

START TRANSACTION;
    DELETE FROM
        pimentel
    WHERE
        id_pimentel='1';
    SELECT "AFTER DELETE ROW OF musics TABLE" AS 'LOG';

SELECT * FROM pimentel;



DELIMITER //
    CREATE TRIGGER tgr_insert_tabela1 AFTER INSERT ON jhenifer 
        FOR EACH ROW
            BEGIN 
                INSERT INTO pimentel (cpf, id_pimentel) VALUES
                ('088.000.999-99', 1);
            END //
DELIMITER ;

INSERT INTO jhenifer (rg) VALUES
    ('222.587.788-78');

